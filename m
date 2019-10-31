Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7FEB670
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 18:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfJaRya (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 13:54:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40879 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaRya (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 13:54:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id r4so4862345pfl.7;
        Thu, 31 Oct 2019 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kz/FCtj2PF4gxBdcIEXsfbI3RO9QLhbBmTNUon1wjBw=;
        b=EST86sBDiClx5CY1TbLmQF3b5slqCpp8BgmFv4VLc7H8M+gWS4n0FyV7tJl/SNCedP
         x+RIjeA/vG/S844grBTtcbmvcnGfRwRgmdoeUSOCuvmE+08qpPH2Uew7FU/IbFCTaNXV
         NpOGNwzYATmj3M6w2DDZ86mwPurmvgfdrfNEb96YHl6L+leWAc3qLdpRuuod4c22wjbZ
         dbUTVnX4+UJkxWXqRXIFlGytjAhwWnqjf5mYXYr11Z9rB+b6yF1fgfpPI7azzX29zQ1x
         SwZE+rDreClmrLI3TroX6/PZGpkboSq9KsDv1ati/aajpk7JNZBDXS2U5Ed8zkFTM/Kz
         dc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kz/FCtj2PF4gxBdcIEXsfbI3RO9QLhbBmTNUon1wjBw=;
        b=Zw3ydVs4mPPVGreKYSAOPbJPczc/UpOsqj2vLifZRouQthVSFDvlydlsKoF2YXISM8
         1upCHH/AoGzNslJWL1UIIm/dPJl0VLP132H/39FLIIozp5GAYexsO2KmtXNXJIhc1wzZ
         gR6zuF7zP9dvAYyF2q85a4adCOw40J/nir/DU1jV55VMe4s+EtIIW0cl1hlw21GMzj/G
         EgK0hAgkUKFp4qVH2vBmx74IATBkBU/FLu5FZrIcSZfQ6TTxRzV25D5PzgskWe04WeYR
         jvx3uVNrkxxitkSyPzlZSmIvjnR2g/9KMoksZ4Rq486RTXREuo+gkCwVOV8bqwGU3R5d
         QsBQ==
X-Gm-Message-State: APjAAAUERY3z1V10ECJa85Wi4RbCR6yGPqUu938DZNtJ0qCIdYM2hM0h
        CV/kmjYsiaVwV94kbt7aeHY=
X-Google-Smtp-Source: APXvYqzPEkkqE2XdSGKjYOFeXoi4DM/BqcfRzbuG+/8iiXNsBYnzSNslwun+1RAYM3et3ScThxGGzw==
X-Received: by 2002:a63:1a46:: with SMTP id a6mr7805345pgm.3.1572544467672;
        Thu, 31 Oct 2019 10:54:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j7sm3523599pgl.38.2019.10.31.10.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 10:54:26 -0700 (PDT)
Date:   Thu, 31 Oct 2019 10:54:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191031175425.GA25602@roeck-us.net>
References: <20191029223214.18889-1-linux@roeck-us.net>
 <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
 <e62b6763-0d1b-3359-6d3b-cb31e96bb862@roeck-us.net>
 <20191031134549.GB4763@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031134549.GB4763@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 02:45:49PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2019 at 07:20:37PM -0700, Guenter Roeck wrote:
> >> The nvme_init_identify() can be called multiple time in nvme ctrl's
> >> lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
> >> should we need to prevent nvme_hwmon_init() from registering hwmon
> >> device more than twice?
> >>
> >> In the nvme thermal zone patchset[1], thernal zone is registered in
> >> nvme_init_identify and unregistered in nvme_stop_ctrl().
> >>
> >
> > Doesn't that mean that the initialization should happen in nvme_start_ctrl()
> > and not here ?
> 
> I think calling it from nvme_init_identify is fine, it just needs to
> be in the "if (!ctrl->identified)" section of that function.

Excellent, I'll do that. Thanks a lot for the hint!

Guenter
