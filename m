Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47684BE06
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfFSQ05 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 12:26:57 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35036 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726143AbfFSQ05 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 12:26:57 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x5JGQtWY006784
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 12:26:55 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x5JGQoG7005046
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 12:26:55 -0400
Received: by mail-qk1-f200.google.com with SMTP id v4so16185455qkj.10
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 09:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=zf8D4/iHtP2cQ9qCWTeKz8g4gkGxClanrDvSj3UhfAg=;
        b=rj0H8B/yMTGGFS7sJMAxy4XFu0RSCLnxAu0RwIU8TiJZBeenU1pkNcHR97Cl9pvCwh
         QsKU3SGnUi6XKi9mP662hdQiJxfvQY6gX6oGIuFcSp2Behs8DO94pLvRLOKy8C2EShji
         ZtRcND8y2JlYEBxF/mhopYy6zMYag9tH1ZjBzxekxaya35s55TrqA2hnnPsb6zi7rItH
         J5lvwya/xSEGLVmE0AmFGdAeXOv+aAll8I2RQM6HuEKPkduY2XsBxG84HFAHZAbRv2+A
         WNn3X+aV/PK47eZJt3DYJWPQWyWiOPDVf+2nLwb+jtFPmeIRxcMhmiQrSh4MeZ2tYV5y
         JqjQ==
X-Gm-Message-State: APjAAAWm+Fx097B4jBsJ7El2l+yllevM0yv7M9wR941tcHykt0KOILwu
        /NDJz4QEAZGtm5P6Ooz0RNJT8x41gs/ydv6/9eq5bymCWdqBfg9g7HQ5X/Ar3wXenmFP5oUcqMu
        U/YBwWNZHRNkc+iLFcIyWhJ8BQn97lg==
X-Received: by 2002:a37:90c2:: with SMTP id s185mr51576941qkd.161.1560961610488;
        Wed, 19 Jun 2019 09:26:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxH3bOZGy53aUzHFJaZeZ0VPGLDh7ReM6TxRcU6oSO7jcWufcggfBfs/wqUKe//XAKCkkKV1w==
X-Received: by 2002:a37:90c2:: with SMTP id s185mr51576904qkd.161.1560961610129;
        Wed, 19 Jun 2019 09:26:50 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id z126sm11285820qkb.7.2019.06.19.09.26.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 09:26:48 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Fabio Estevam <festevam@gmail.com>,
        linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: [IMX] [DRM]: suspend/resume support
In-Reply-To: <CAOuPNLgYN3FDvNsaWqom45h7aFz=HczDdL-QoHOc_Sreqf8T2g@mail.gmail.com>
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com> <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com> <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com> <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com> <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com> <20190619150406.GB19346@kroah.com>
 <CAOuPNLgYN3FDvNsaWqom45h7aFz=HczDdL-QoHOc_Sreqf8T2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1560961607_1605P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Jun 2019 12:26:47 -0400
Message-ID: <22247.1560961607@turing-police>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--==_Exmh_1560961607_1605P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jun 2019 20:47:34 +0530, Pintu Agarwal said:

> No I mean to say, there are lots of features and customization already
> done on this version and stabilized.
> Upgrading again may require months of effort.

This is what happens when you don't upstream your local changes.

And no, saying "But we're a small company and nobody cares" isn't an
excuse - Linux carried the entire Voyager architecture around for several years
for 2 machines. Not two models, 2 physical machines, the last 2 operational
systems of the product line.

(Not the Xubuntu-based Voyage distribution either - the Voyager was a mid-80s
SMP fault-tolerant system from NCR with up to 32 486/586 cores and 4G of
memory, which was a honking big system for the day...)

https://kernel.googlesource.com/pub/scm/linux/kernel/git/rzhang/linux/+/v2.6.20-rc1/Documentation/voyager.txt

The architecture was finally dropped in 2009 when enough hardware failures
had happened that James Bottomley was unable to create a bootable
system from the parts from both...

So if your production run is several thousand systems, that's *plenty* big
enough for patches and drivers (especially since drivers for hardware you
included in your several-thousand system run are also likely applicable to
a half dozen other vendors who made several thousand systems using the
same chipset....

--==_Exmh_1560961607_1605P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXQpiRgdmEQWDXROgAQLgiQ//UFBElVIVrz2j6hgbDsxrSxbNiWZ78XOp
zPJi/jWSZmMEt4QpNByA1Ll6udI5h7c3MprYyiFm3YCToErjrV24+LgkCNqGzV3g
23AY8/bqTjLnA10eT87df7SOdHkfw5CKH89LCEeq1RqK7UYIAN2CMT0MRaPQriD2
NwoJipNt5YamEDZcZEiVqLWtw2mmLTLEt+kZRg57m9scTrSF96Rg10VFzvA9yi2J
4RUBNmnGNTh/2qXjkIWa126v/jaYrcktuoaMYgUuVQnvZxb8K8VzkawE0yvyVhsV
Xn0B3WpNmg61Z9C23hmjSTw/XCn9a0vVXckDeoWYEI1fQgT1okgMQegHvtcUAniN
Bilmu9+FxVCdus0s4SnjH2jE7dIUXj328ys4imgMidBXxsSMpA6Iht+50/vgxKLV
XOkdffMF7aw3IWiLvsKagEybyq/1VYGnbmAU+h4GrJphs5Qs55J1CDLTGDcrUKqj
QSlr48Bs4fGgqiPYs9G5U7e1KXRJdcn8zhmx2HxvDudAqnXVKonxj9cvFqdxHs83
wWB4Bvp+DCksNVefEXpSXbZddKqmiU51F2lH8WMZ5dxhA/WN+r/oiMRh28gzS0yR
0xVbWJWDnca0Mn+hp0RioICxIljGiEvQTiWK9IrDj8zJpQNPCntCuqmYQ82bj8yB
8YAja57nMkE=
=641k
-----END PGP SIGNATURE-----

--==_Exmh_1560961607_1605P--
