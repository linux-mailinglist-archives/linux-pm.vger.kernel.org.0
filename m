Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE770E3DC
	for <lists+linux-pm@lfdr.de>; Tue, 23 May 2023 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbjEWQ45 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 May 2023 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbjEWQ44 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 12:56:56 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19B18D
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 09:56:02 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6238386eb9cso64428656d6.1
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 09:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860961; x=1687452961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I895gSBgpzDKKLUi/M3iUfQpFGQN//aYkK8LK5AguTA=;
        b=k6P4N3oGAYbyWhpljoFKyydFingC6SwRPzisF4/aPxDtEh7YvRahH5zbbXl5G79RK2
         6QcgVF3uE5p9xl26x5B6oV18X6WsB4j37LafuEBZTcl11hjYule9sie854uhrJ7vodxT
         H28bPED9xjHl5lIZOg0zhySfa6ppFnSkjlbCtC/UM4NeC1TQFfGGGEWPK/QKsec3l58p
         6ayCJg4GHozHCZjaRkxVQfMPSdrRCtpkKasMIG3ECOBn29SVmvCdL/0d+BZGny4qXsaI
         1GspP+D6lk81/0KQAC2ecMTAKgBi/A110jLivVaFooANNWYISlxydHqEQmM8dTH1vmRK
         dkpQ==
X-Gm-Message-State: AC+VfDz2jXcv1beVmE7HYdMlUbY8GQMK2rEcVUsL2cTyn/70774J9wUS
        cn82MHvSVlO63eLkGUpodOtw
X-Google-Smtp-Source: ACHHUZ7flOXCsLoBxKovnaaX/oi0L/ZSk0yhITAbxyTXaocIhbpqrKl1r3JlMCNYZavegSmc6yz+9Q==
X-Received: by 2002:a05:6214:2aa4:b0:5ef:a772:2731 with SMTP id js4-20020a0562142aa400b005efa7722731mr22618918qvb.11.1684860961501;
        Tue, 23 May 2023 09:56:01 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id cz10-20020a056214088a00b0062120b054easm2895666qvb.20.2023.05.23.09.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:56:01 -0700 (PDT)
Date:   Tue, 23 May 2023 12:56:00 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 17/24] dm-snap: simplify the origin_dev == cow_dev check
 in snapshot_ctr
Message-ID: <ZGzwIGPfRggsU0Ek@redhat.com>
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523074535.249802-18-hch@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 23 2023 at  3:45P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Use the block_device acquired in dm_get_device for the check instead
> of doing an extra lookup.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
