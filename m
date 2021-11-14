Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F211044F79C
	for <lists+linux-pm@lfdr.de>; Sun, 14 Nov 2021 12:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhKNLbt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Nov 2021 06:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNLbs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Nov 2021 06:31:48 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC65C061746
        for <linux-pm@vger.kernel.org>; Sun, 14 Nov 2021 03:28:54 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id i194so4331438yba.6
        for <linux-pm@vger.kernel.org>; Sun, 14 Nov 2021 03:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=l2AjIcA200luhAvIV6Y4Gf8Evv6mr+gMr0zSOMeBGF0=;
        b=h86VnA102Vu1evHSQ1R7Q819LtTvF+Qn61YfJ5qLxKgqAzec+K2QpazzBlceBUe+Y/
         2Ngo4kmgRJshl6B2R234se9EdbFHDrp80AMGg8r7Nn7CyFK6daFYED4LOz5gH/lkRx1d
         HeeU4C0f2L9M/upnPLE0mLVweJMtT2a+HSXyyNgwJFMb1askCn3D2CarW2P2R4HM8jDT
         hFjRTMZBlTHnlC929IDL6BJHLfVUr856U2K7L2VRnUEEA3JMONLvE0h5tt/6tzIVtesb
         l/yFNSaphop0dCpvEYPdP+/JsM96IwmEmrHmKyk3ufi81AVoQP67ffUuE8B00kvS/KUe
         8pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=l2AjIcA200luhAvIV6Y4Gf8Evv6mr+gMr0zSOMeBGF0=;
        b=F1xW4e9e916PQo4KalE42EMPW1GecHLqqYILe+1SD8QzWd3O4pIz6bjMGRglxJTXtb
         FvLP3D8HTy/S3AJ70R41g/ujUHTOq2f92z9zlOUjSeBNaQUkZKgHW0NhG5AHs2VaE4dZ
         oVfXSDIC8z6oxPcN1P13kKPgLfmaSzeznBT9aHMSOMBpQEI4zRptMbZp2sl7Q+f7OTym
         1DeumNH9VjSgTyjAyOpn3aYDJckIPPAQ5rOnbvzG49wfOR4kPV8yM4WuXDHGwW4BPKpx
         +1PrubmNWy+gyzNkXjsOgGsy5u7DAiXAbhWpP2GszPzIX0nVEcl7C6w1Xpm4JjADa0WZ
         gGcw==
X-Gm-Message-State: AOAM531d+79GYQddZLbMRPhsw/J8WY0AcmK0bhMOnNM6vaeXi2uifcTV
        aUUCNGAL/Kj8S7hikDrBrsFqdL8IQ/SQZdWhVVTpkqBNhCA=
X-Google-Smtp-Source: ABdhPJwdCNR3IpyQzVEc/OrL5EeghBgvW1AwGH30eWoLDTn7NIDqFoaLswRT/Dj8jQDBKx+fG9svuct3SaXxfqQdKTA=
X-Received: by 2002:a5b:d0e:: with SMTP id y14mr29193377ybp.23.1636889333351;
 Sun, 14 Nov 2021 03:28:53 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sun, 14 Nov 2021 19:28:49 +0800
Message-ID: <CAMEJMGEetqxb7h5DEzci9vcBBxvS+9nJ=UF59HPqasNwmWLuXQ@mail.gmail.com>
Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch
 is Running an Operating System with Linux Kernel 4.4.120!
To:     linux-pm@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A
Switch is Running an Operating System with Linux Kernel 4.4.120!

Good day from Singapore,

I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch is
Running an Operating System with Linux Kernel 4.4.120!

INTRODUCTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

My name is Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 14
Nov 2021. I live in Singapore. Presently I am an IT Consultant with a
Systems Integrator (SI)/computer firm in Singapore. I am also a Linux
and open source software and information technology enthusiast.

You can read my autobiography on my redundant blogs. The title of my
autobiography is:

=E2=80=9CAutobiography of Singaporean Targeted Individual Mr. Turritopsis
Dohrnii Teo En Ming (Very First Draft, Lots More to Add in Future)=E2=80=9D

Links to my redundant blogs (Blogger and WordPress) can be found in my
email signature below. These are my main blogs.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent versions of my autobiography will be published on my
redundant blogs.

My Blog Books (in PDF format) are also available for download on my
redundant blogs.

Over the years, I have published many guides, howtos, tutorials, and
information technology articles on my redundant blogs. I hope that
they are of use to information technology professionals.

Thank you very much.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

***************************************************************************=
*****************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
