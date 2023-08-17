Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F27801C6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Aug 2023 01:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356146AbjHQXlr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Aug 2023 19:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356204AbjHQXle (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2023 19:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1805F30C6
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692315645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rTrEHxr3/rgVj2kGdngCSyXx3bBs8bGQLPtNlGAFwQo=;
        b=GMElQepF5KqW3yQo23DhSVqXlWfxoAvpaap7R5FAB4SFlQxfzg7zp4FvOLhcV0S22rn/lI
        gkrIng33lZ2IiJiqh8EQeSM06Cok27U8P+V7PI9zqvUVmUzM6fRF/Qip00blwZhZgnD6cz
        sya4k1hhryyieNugkbJ8vIxaiG5MJK0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-R1gnfBi-Pi-d4TM7hVSyLw-1; Thu, 17 Aug 2023 19:40:43 -0400
X-MC-Unique: R1gnfBi-Pi-d4TM7hVSyLw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-56c6c502822so426137eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 16:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692315642; x=1692920442;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTrEHxr3/rgVj2kGdngCSyXx3bBs8bGQLPtNlGAFwQo=;
        b=b1uSna+xc2Jp77CcIyEgKsL68Ge1AKUAXfgfYjrobyDVvbsE/QN4AaanJqIsenZX25
         vfL+W58E/YV81FJWDqlyihQ4b/+gdvuOxKP3/gB+Jd68HFO8bVlzPZV4aqaItman6mxG
         f0sL2ba2PP4jvG6HyLhTIWGyhAWYcz8LGIkZcIoo1i7CEO83noyignxZTd604xu7SWUa
         1kNZDQUIeqH1HGSWYj86A7YFCRqjpYyoV9mo1JJuMWSPclpF67Luz1bEYe6kRmYnZYvA
         X/cXaiaqNXGh7M+mLFyy7KcBCWjgJoje+dpEeE+aHDDXmcyG+IPR4/V7i3vdCgNgnmp5
         WeTQ==
X-Gm-Message-State: AOJu0YwTrswbmWZBf9+4yBdFgIT0rhdiDXtcOVS1jDc1gs7tJ9ghbRPx
        gqytHSsNb4tFyTzJ5fdUvlOW7QHwrh/iVLhOVuckHzSquuMG6Jb7G7ihk/APDLPq+k79TykUTFW
        e+zUbzTG/shDpS3YcLj7LCgruUcA=
X-Received: by 2002:a05:6359:6488:b0:137:d0bb:6036 with SMTP id si8-20020a056359648800b00137d0bb6036mr876975rwb.1.1692315640623;
        Thu, 17 Aug 2023 16:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSpQRAsPuI44RrFwg+S7bPclSIqpChEbOCQg9NW5JdfvILfiZ4CVPLZpkM/MouwdijF/sKIQ==
X-Received: by 2002:a05:6359:6488:b0:137:d0bb:6036 with SMTP id si8-20020a056359648800b00137d0bb6036mr876933rwb.1.1692315638875;
        Thu, 17 Aug 2023 16:40:38 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y5-20020a0dd605000000b0054bfc94a10dsm181134ywd.47.2023.08.17.16.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:40:38 -0700 (PDT)
Date:   Thu, 17 Aug 2023 19:40:36 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: reset: nvmem-reboot-mode: quiet some device
 deferrals
Message-ID: <ZN6v9I0YPiiqcaTo@brian-x1>
References: <20230817214218.638846-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817214218.638846-1-ahalaney@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 17, 2023 at 04:41:57PM -0500, Andrew Halaney wrote:
> Some errors are being logged that are really due to deferrals,
> which is confusing to users. Use dev_err_probe() to handle when to log
> at error level versus debug. This also has the added bonuses of logging
> to devices_deferred and printing the error value.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>
Tested-by: Brian Masney <bmasney@redhat.com>

