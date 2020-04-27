Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7851BA072
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgD0JxO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 05:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726434AbgD0JxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 05:53:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB5BC0610D5
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 02:53:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so19770284wrs.9
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=csq4kjxMcX7yi6/sCOr5uG9HWQ0xBFcUG9f3NAhrCRc=;
        b=ucbhQMAmJHeml9eJHjaC2XGS2Pkyn3DTTWPocyrdQKu/Cklh87Qm0/6t1ZRkWVHJn+
         cezjmwaJftR0w4J7BMDcPZTvwGUUFWBmSqLliHNJP6IAc0Qtj4A8lW1QSyKBbgc4a4eE
         ST8aScMAD7oQr7eFmWcfAl6/apkkQiAUW86WcqqqeoFrV/ogjH82BGkUAS6OnCGGE13C
         eZ/OFNR5xRkijdiTjHf4i7wAw6sF+E5mZKBU/y0+eJQYuCLm0u/tkeHOG+J1d+MPaZxV
         935Ictbg/PklCkaVMBTXct5tIuhoCcFRZF1HQ/MGQtDpwMMUHYc8steYUN+CaQkHdqrt
         fkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=csq4kjxMcX7yi6/sCOr5uG9HWQ0xBFcUG9f3NAhrCRc=;
        b=Zr7Mq4z6BVIcDlspUTqNAPJJ3LhJ9FD4KdQaYvH9bSYwKEQYfBss/lw6UM4pil3Yac
         tl8cITP+xVbU0mFD6SPW4ZAkdLN9gPFwMUMyTOFJISfpTJ2pjMGamjZiDLEOjoeG4jev
         s3TKOYckb1IDuO4yg923RToNPoeJWcEzeT1JzyPdY4ZYWNKxeEPBkdtn3OSgp5dPsgDc
         DTe000Xtq3C5lXdNza5nhWsE1s7VwSrkmh36qWj5v1mR6M3qpFKt57Y48qACMYybgJlc
         Z1BGSHjXZEXxhg6TsRSCQOsHnvTLJ88jLfOqbXUoS97QrsMsCacgCWWhZYFMR4Eptt9M
         MWow==
X-Gm-Message-State: AGi0PuYRoo50ztQasb3f6a2bL51Wkk/nmbEbv8x5v31IzmO90gaudpIn
        gzFBcfTQpFfRJQlN/3cifx8=
X-Google-Smtp-Source: APiQypJaDwWJ47cyjMZkFrceCp5gRSSsZiEsGBGpij94l0gsTK2RM46aS1y8bowsG6swJmxS0RWqhQ==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr25171938wrp.28.1587981192015;
        Mon, 27 Apr 2020 02:53:12 -0700 (PDT)
Received: from dumbo (zarathustra.tor.k0nsl.org. [2605:6400:30:fd17:5f56:ce5b:f14f:e252])
        by smtp.gmail.com with ESMTPSA id v1sm20859473wrv.19.2020.04.27.02.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 02:53:11 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jT0Rm-0007w3-I0; Mon, 27 Apr 2020 11:53:06 +0200
Date:   Mon, 27 Apr 2020 11:53:06 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>,
        954061@bugs.debian.org
Subject: Re: [PATCH 0/2] Preparing to phase out uswsusp
Message-ID: <20200427095306.GB29259@dumbo>
References: <20200413190843.044112674@gmail.com>
 <1636190.8qWULXYmPk@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636190.8qWULXYmPk@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 26, 2020 at 05:46:37PM +0200, Rafael J. Wysocki wrote:
> On Monday, April 13, 2020 9:08:43 PM CEST Domenico Andreoli wrote:
> > Dear maintainers,
> > 
> >   it is my understanding that the usermode software suspend is not any
> > more the first choice for suspend/hibernate needs (uswsusp tool did
> > not receive any update in years).
> 
> While the last part is true, the user space utilities are still usable.
> 

Indeed I've been using them until now and work perfectly.

> Moreover, the kernel-based hibernation is still missing one important
> piece with respect to the user space variant, which is image encryption.
> 

Interesting, is it advertised anywhere?

> That gap needs to be removed before the user space variant can be
> regarded as deprecated.
> 
> > This small series aims to better separate the kernel side in view of
> > a future phase out.
> > 
> > Marking the new option as deprecated and disabled by default is quite
> > extreme but I've not any specific agenda for pushing it that far,
> > it's just my interpretation and could be totally wrong.
> 
> It is not totally wrong, but a bit premature at this point.

Thanks for clarifying.

I CCed the Debian bug which requested the removal of uswsusp from
the archive.

> 
> Thanks!

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
