Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8B1727BC1
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jun 2023 11:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjFHJoh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 05:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbjFHJog (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 05:44:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279D22719
        for <linux-pm@vger.kernel.org>; Thu,  8 Jun 2023 02:44:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30c55d2b9f3so278071f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2023 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686217463; x=1688809463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UW1P1+u4z8C1yYHhcCc7D6z205h5xRpA4Pis0U9UMY=;
        b=yaY1SeETpr1491wAArwoEz9AJZvZ5z5Oelfq8FTwZjv5Pt/tYo5/JbhJmlnsdXccgT
         rV+izm1qoxfwqsvCOevTNpa9AXiPp34leL/teWpFI8DnWj2gT9oTkJf5RM1JedYJsqOR
         dOTz2gvKJANj4eEOoND3rs/e3YQmKzzRMznHOfQHFfxuyaer9zt098pnWbKtUtWgrjpL
         rngkJTI/oyNl1h5w6WjYslic/vZHxQYsDYNvUly4Suef2mFO3KaGuI4pOX3o87LWbC1v
         fP5qRuJh7sd0u5OqO4m/B3exo8izpU2YK4CbQWdtPhbZm6I3/7vshaMygPH9B4aEMU3h
         0vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686217463; x=1688809463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UW1P1+u4z8C1yYHhcCc7D6z205h5xRpA4Pis0U9UMY=;
        b=VkosC7LObckRRMgKFhb4BOzg/BAQ/dN2D4OqH64IpGvHNFCNKv7pH4rPHzz3xsoyzA
         nxL+GK+eQtOKBEyZXoO4MaJBX+R6bPc/fi1YRoxk+JMb/kT8djM79SK3pI9Zfy35z2m7
         p3ebMbbwousRCFKt2N7mqn0CyRS59V1Ipqpp3h1SX8IJrHp9Qpa0mOOdeDQ9uAYshIMk
         Ab2f4iGdgOBK1LOJsMKKhgOZ58pIRgL9W1+tSB9JkTlflktUEjINSqvKVV9Aeagq7k6S
         /Jztouoxiz5KEHOQ+glg1z86FkaSxXfbjUIHnL/873gpvfCHGX86f41AQmbzm8x/i1t/
         5uYA==
X-Gm-Message-State: AC+VfDwQLJP57vos2wDnmhD/tybo9hq6inIPTDBnugcnZFeJaRcYrM4r
        w9TsvuCgzGYGGfprZzIEorK+Gg==
X-Google-Smtp-Source: ACHHUZ55+QiuKZDDVF2xerotwpMLkKmO7qQkxSxt7AJ+yBOXmT5EW03OqeXuJJ7vWtahwa0aPclqwA==
X-Received: by 2002:adf:e60c:0:b0:30a:e3da:efe5 with SMTP id p12-20020adfe60c000000b0030ae3daefe5mr6178509wrm.32.1686217463182;
        Thu, 08 Jun 2023 02:44:23 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb51000000b00307bc4e39e5sm1027878wrs.117.2023.06.08.02.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:44:22 -0700 (PDT)
Date:   Thu, 8 Jun 2023 10:44:20 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 06/31] cdrom: remove the unused mode argument to
 cdrom_release
Message-ID: <ZIGi9GMGeKruSrrW@equinox>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-7-hch@lst.de>
 <ZH+6qd1W75G49P7p@equinox>
 <20230608084129.GA14689@lst.de>
 <ZIGVn9E9ME26V0Gn@equinox>
 <20230608090444.GA15075@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608090444.GA15075@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 08, 2023 at 11:04:44AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 08, 2023 at 09:47:27AM +0100, Phillip Potter wrote:
> > Yes indeed - I was under the impression it was appropriate for a
> > maintainer to signal their approval of a patch to maintained code using
> > a Signed-off-by tag due to their involvement in the submission process?
> > Apologies if I've got this wrong, happy to send Reviewed-bys by all
> > means.
> 
> Signed-off-by is for the chain that the patches pass through.  You add
> it when you apply or forward the patch.  Just give me a Reviewed-by
> tag and say it shold apply to patches 1 to 6 and I'll add it.

Thanks for the guidance. Please apply the following to the block patch
(1) and the CD-ROM patches (2-6) of your series, all looks good to me:

Reviewed-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
