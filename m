Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E37044E6
	for <lists+linux-pm@lfdr.de>; Tue, 16 May 2023 07:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjEPFws (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 May 2023 01:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEPFwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2023 01:52:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B2540E1
        for <linux-pm@vger.kernel.org>; Mon, 15 May 2023 22:52:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso7891346b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 15 May 2023 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684216366; x=1686808366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZccG4uIRo7CsNZMhsJ6CCNSTyo4mWHxGlBVFG2V88w=;
        b=VUCSQHNQ7T7rZJufnY+Z2j0d1XmZJ2oZ32+ajJ1XPcOqeByQccmeoxCBDZHgTjsTZy
         X5cIMmzph8VZNxg/DrpKEEyWLdnhJsQT6RmaGPzudIFROFh4skDwR26yDXIY3QDgE0pp
         duXiiD/AOdTwuksF+glpR/daurdXaZoUro0d3ZcIyU5AXq5XYGXl+KLE2oIPcY2YQ11w
         Ay77u+Hh8wmgLXXFhB2ksVmYUTOVImNYAARmNaSdfKzdTIvJUlxtKlyJwqDfe4aHoZyg
         juJSr2UkVRdMum1DToDnE5BsgdtCH8+txFU57z58pN7SNvExqLNcdFfpn+iuVtDj0t8K
         V0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684216366; x=1686808366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZccG4uIRo7CsNZMhsJ6CCNSTyo4mWHxGlBVFG2V88w=;
        b=Sd5TnwwDmOCAxV3s0fkvyA0CTjoegr+Ob68QMZHTW3bcKZegRclSWfas8jAuWbQNla
         Ue76n0L6Huis2xkZotpIrMO8HMNO3gJzyjR06w6GzDwXV76lPleHQlt+S9G9rk6uDkiU
         POOkZE65/CI1FqE2dHDwmka3FnIkaHLVP+dHNehgYYDx7qKvMzdi1R5t1ax/7li+fV5D
         +33CJkRDv7WHz40ZF2SrjQYHmnV0Q/NXb9bNqmC2Vd2awLz5wN2DmemQt+RmFTou36Tp
         WCG3J/6z93iZt5svbbulyGt4UE9boyJBrnu4I5JIfvKqN2H1+NsYSsf8+Kms9Jl2nQEU
         hq4Q==
X-Gm-Message-State: AC+VfDzNxPLZ2R5QuiXkmBRHgjUlK9mykZJlkDGeg1RzGrjaj1u97Q0x
        xLCqgg3XuOtqApwLmdxSl2PRkg==
X-Google-Smtp-Source: ACHHUZ4g6s0Ec9Wt1DikFOpmCRplYseZbig/nabKGOh1A0zHibPlOtpL0Om/DkFQC3KoYIXBZ0O+Xw==
X-Received: by 2002:a05:6a00:9a7:b0:638:7c22:6fd with SMTP id u39-20020a056a0009a700b006387c2206fdmr52364827pfg.1.1684216365743;
        Mon, 15 May 2023 22:52:45 -0700 (PDT)
Received: from localhost ([122.172.82.60])
        by smtp.gmail.com with ESMTPSA id j22-20020aa78016000000b0063b87f47062sm12373415pfi.127.2023.05.15.22.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 22:52:44 -0700 (PDT)
Date:   Tue, 16 May 2023 11:22:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     ray.huang@amd.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com
Subject: Re: [PATCH v3 2/2] cpufreq: Warn if fast_switch is not set
Message-ID: <20230516055242.yfbf2jhdhz7uuwtx@vireshk-i7>
References: <20230515113404.4259-1-wyes.karny@amd.com>
 <20230515113404.4259-3-wyes.karny@amd.com>
 <20230516011001.epa4xlvbiimu6ai3@vireshk-i7>
 <ZGMZUhWCU18Wn/47@BLR-5CG13462PL.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGMZUhWCU18Wn/47@BLR-5CG13462PL.amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-05-23, 11:19, Wyes Karny wrote:
> Sure, I'll do that. But one caution if we return failure, the drivers which
> has the above conditions won't load.

They shouldn't :)

-- 
viresh
