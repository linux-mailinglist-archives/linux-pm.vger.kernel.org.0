Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE03D1E984A
	for <lists+linux-pm@lfdr.de>; Sun, 31 May 2020 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgEaPCA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 11:02:00 -0400
Received: from mout.web.de ([212.227.15.3]:58131 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaPB7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 31 May 2020 11:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590937288;
        bh=J/eJtvv3gAULoPyXTLodRrIJ9L0Dv9wyGP2oxhrU6KM=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=WRmLi9n93AA2t75dWfWmrAloEg4YATc5pFYzD704u5ptlMcROwH9kbwyr6yiIdNuQ
         AaJo1rd0wltTFfDSq8CzfW798Rs9QF2r4+Ap2UkPb8WL6jzwthablj9T4J0NF186XC
         LStDwREoueQLWM+HoNbC2HpAOnzFskM48QWihHGw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.19.10]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyE3J-1itgB33Fif-015Zk4; Sun, 31
 May 2020 17:01:28 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Kangjie Lu <kjlu@umn.edu>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: supply: bq24190_charger: Fix runtime PM
 imbalance in bq24190_sysfs_store()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Message-ID: <e3faa9ac-c35e-41cc-a298-84ee81c74183@web.de>
Date:   Sun, 31 May 2020 17:01:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E3uoQ5Rd3D1rVr3S209zE4D6OKnXNVtKjJzBHOenjUIqRtrW3tR
 0yN25lnBczmeDsnHKksXhIZKb+9PSuH4lU8+GZJ1SCj75O+5jaDx7UvO5yKbY2ZldCvKXcX
 Uj2Ypgy4VPORJqjlfdEFWpt8oHXsYKDfKFsjV4r4ssKlodx5/yPwoDgE5LKFyt0WwFb+nvE
 3mSAkbIV8rsGfa/vcPgQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:35H5Mmqidv0=:iCoTpGRmXTgJs53c8SoNbZ
 fcUYGZO3IT26ULIbo2EVsu3ITRAUXB4ZJIwZPWQucY97TTVtZIOibq/nNEt5YCV01NykCgaYh
 bNixjNBxrEMvxqxflzmhKffZj2U1VpxrI/abGrr7HjQVQ54GXBLg1zAEC862a5qvoRQiuKrE6
 nGMx8vROt0gh/Eac0tECbkRTOPKzxiD6M31Lh8EgyxEk/KoBTIZjl+24jZ8ypKcfKEzghG+D5
 JQKyVRaZUaNbtQZqtJzKHpN/CYQw9befqnQ/t05d08/8SV2uwWpRs0Ef62uDeTBZcF+TGJoFA
 Izel4wbnr2yOzUAabbMYJzIKWxkMgGMzV7X2NYkvDJF5z1iN3pq0KOJEo/FuXfHvWnkZkLCry
 FvQ5Mln791FTYZMctutLV/ocOkt/OdZICwDZhfoTLH2FPP4RUGmKQXcqUcPkGv1D8gnU0s/UD
 bwJoTORtCPXGnoN0PR7cCKyj40d1gPMYx/Zq/Z5GsembCGYJf3nFz0f+pZchr+2oo1b8K962A
 NpjoLweWr1h9EzGv7ycuENl8782dbvqH9mipLSFEydNyPHgbyR9HofN4SnUalx3INmzShfAdV
 UP28Fl+Lh0z9npnAnhfjKXmPeYyuLHEusYSk904juGTw1PjrKfryuVafabws3XlMpiBwKO/gE
 v+ZG5xsccdZDBvRQqZU8WQKPdWfgC/VWfCSFmRgmZ4PqJvttj+T4qLkW3u+inMCoOgMusPTcc
 EIsGx5yLtAz40ZrVCrdr/siJIrgNQYrTA2ot8JqXYoUchxxmnIKYU1iLNxd0/J9QucCSF4Iv+
 biKD7IoxkiaOQODlBYd58jqFUFGNP8km5sLRyzZVpTdI657/Plb83wm2c9bRlGCqQFOhRWtpq
 yeIJlodAKgMUCrOO1mLxrmtwr/rT5XWX3wyznDCunUbmiI6bAjpLaeBLnNO3v8O1PPR8OXoTQ
 jegGr25eOYrFedd08LwyKEYqhOtVaybMBQIb+Els9im2QmK0xi5BLYjilXq9kvy/rdU+v7G2Q
 pNep3MheyPvMTzBmKSbdc+Xh0k6UUzPqqOCxutSWiikSYQhAsOnfq11Sg0mJAAOg72C8X8/qt
 yv8BD53oMxGUQzuqjLqtLT7C5DMk9N+3hJ6tWCIpPcUFe9AzaTpewPYig/iKhhYPwAFVae1wg
 FDMD2R9ujfwOCy1Lec6y9T5pFxI7+6OcZeyIaxSkgas7UhTvRUJhRZ39+lUYUETU0BBBYBNSr
 DyT9t+yv7HuJJ1s46
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

How do you think about a wording variant like the following?

   Change description:
   The PM runtime usage counter is incremented even if a call of
   the function =E2=80=9Cpm_runtime_get_sync=E2=80=9D failed. Thus decreme=
nt it also
   in an error case so that the reference counting is kept consistent.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
