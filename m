Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254204EFD0B
	for <lists+linux-pm@lfdr.de>; Sat,  2 Apr 2022 01:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbiDAXVD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 19:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348462AbiDAXVB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 19:21:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F91A770E;
        Fri,  1 Apr 2022 16:19:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g6-20020a17090a128600b001ca5c2477cbso80524pja.0;
        Fri, 01 Apr 2022 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :subject:content-transfer-encoding;
        bh=JzoLiDpzKa7W1p5akpLIliye1Kl0aJ+omhs1Hnbktzk=;
        b=PJ60DbjAxo2h7nAn2P5hX4dp48iJ8MUHuiyTIu0io/RxZwUbM3zHQNvg/IfCifRpH8
         Y/Pjljz9+3b8flZvrPwKC4XW6G5mVfWSZumxr3sz2r1SsFNUPJSfauvSs0KaJXqZ8i6L
         OWsh4D7F6NA9FlpiFQuk3pjoJG7vmRdwwfxFcBGb/OSiXsRng9EbpcLKFXUf3BqLk44q
         YNaWNu8u5Jc/T3rwwzDVofV5uAJKeGsEnd21C7xltBkBFPyNNGhVkV9fJ7O8WW73AQZ8
         eCjbfXNqOs/K7b3jXkfYVRwJcFuNyIl4xppQo/lqVH/SERU8m4/Pl6hHlDMnvXzZvt1w
         nA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:subject:content-transfer-encoding;
        bh=JzoLiDpzKa7W1p5akpLIliye1Kl0aJ+omhs1Hnbktzk=;
        b=li0FtBSYSL18IlBfz6mpvZqSgkiYm4l4adLm53VRaJ0zz41gTaPcgtiTkRvm0x/TQv
         X61UZL1DEAA1F36wHwGgOJJ9ekh58FPH/7DfeTvNmpc8AviFNTexP3fMfeu1kOH34NiX
         6pTBXGjXos0mhSwh/5sLtKs98uoRbCQKBdCrNjUOI0kuHxcoamMUfwQlWDgj+wZhj4HU
         wss/EOVjQLX7MwUwGS8dXdJqLzTs5qbikyCo9XTdLj4vUcPFjYWwP1MjZn+zOKJA/KSR
         qGNhaXJtGj0M1X1JL5r0haSNQDRPZNuJVcewwnWMJr2lssRWlyehgpnJdywyAaAjKLGr
         PaBA==
X-Gm-Message-State: AOAM530VHG1w+nCRQ2u6MhEUGFTq7uEHUgyBG74CBxu3fCYXGB39BmuV
        MrFO3hQjnWyt0HDeojhftiPt8TROiC4=
X-Google-Smtp-Source: ABdhPJwh8ywVm2q2SwIysx0eYKOkTQWmHo3y/y+rk9yEaBsDtdXMF90J/p0T4RSTLU9F7u6l0+hveg==
X-Received: by 2002:a17:902:d4c8:b0:154:2416:218b with SMTP id o8-20020a170902d4c800b001542416218bmr12868799plg.139.1648855151012;
        Fri, 01 Apr 2022 16:19:11 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y63-20020a638a42000000b0039870096849sm3339369pgd.63.2022.04.01.16.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 16:19:10 -0700 (PDT)
Message-ID: <fffa1d50-f155-b6a4-bf58-22e395d7401c@gmail.com>
Date:   Sat, 2 Apr 2022 08:19:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -pm v2] docs: driver-api/thermal/intel_dptf: Use copyright
 symbol
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Using a substitution pattern of "|copy|" without including
isonum.txt causes a doc build warning.

Using the symbol "=C2=A9" itself is a better choice for those
who read .rst sources.

Fixes: 16c02447f3e1 ("Documentation: thermal: DPTF Documentation")
Reported by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
Changes since v1 [1]:

  - Use =C2=A9 instead of including isonum.txt (Jon).
  - Amend title and changelog.

v1 [1]: https://lore.kernel.org/r/e06542af-aa8b-0885-37a3-bb7bc5fafa1e@gm=
ail.com/
---
 Documentation/driver-api/thermal/intel_dptf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentat=
ion/driver-api/thermal/intel_dptf.rst
index 96668dca753a..372bdb4d04c6 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -4,7 +4,7 @@
 Intel(R) Dynamic Platform and Thermal Framework Sysfs Interface
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-:Copyright: |copy| 2022 Intel Corporation
+:Copyright: =C2=A9 2022 Intel Corporation
=20
 :Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
=20
--=20
2.25.1

