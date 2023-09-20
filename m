Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD89D7A8306
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjITNPi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 09:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjITNPg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 09:15:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC1AC2
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 06:15:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fbd31d9deso6281116b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695215729; x=1695820529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oIDhHctYr7JKAXv2kL+yKQqGU8Rh2f5Gc2X+kLC/F3U=;
        b=eqTtU7bzVJZFoRFjuSsC7qzjDymm3k3b4qenK9hSuLz9pW/U+9AGpYkwHJVNJXO/Ji
         2wnGZeq3IuDd4EsgHdevxd3bGhXOlqONr7VOzpLpOOtuljqg1YeP01NAWRFvTozN2t3A
         k12jiONrdMiibzYvt4MZI/KUF0EXVY34VhpVrBvQLVhr+BhtUe1mQlrMpaUoRLoXQW6A
         fXeX8fm9/prqSPgMSWOFkrWZ7rXtMr15o3Pp1C6doe/L+CFxaOQavr4EHeJr8WqpGDvh
         NaSR3lTf7KpWxKWf4BkK8SvnZ2jnebtmVFjB2QqvXzIgW1tmgoipVRSNl4SZEwoMgMho
         ZdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695215729; x=1695820529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIDhHctYr7JKAXv2kL+yKQqGU8Rh2f5Gc2X+kLC/F3U=;
        b=QHAEcK5kk6rOPj5ni4337drYXoJ5jZHGzyd0k7WD68F7tdaRzyQ6Czhmlt1GPTpOE+
         3soaxv4obNgHs6Y+Vj/VsTX5n/CDExJgYkL5A4sddcjlKT6cte1qXCEvyID0rhwl94cW
         DaqSw8w/4175PS91RZQxm6lzl5m66Zl/StGguj9nThjCTPbeSYf3i56f7TkRX7MjCUQI
         W/ZPKyW0S27HS+NYVhVfihymYuOeZb2gQWHZE1odephH4rA18OhJRw9TaCOFexxkzwHW
         nv4KsjI8eSO4Ie3QDfqf6R9Rg8d9UFZDoA2glEx5ehdyfbPsJtB2ykFQMxQg4jm+SCFq
         gh9Q==
X-Gm-Message-State: AOJu0YzabBp1qw8GIcOL3zns1AtJ9DJx1s0yk2l7G8I93hp0IU5pA9rC
        9sPaGm5d5Ta58sfeh2wDEr0=
X-Google-Smtp-Source: AGHT+IHlxoeeyosTFXOFW39S4sXpnEvECWYUsOjIuA06yZPOZyJHERzgye+h4krvAKzG5EuxM17Y1w==
X-Received: by 2002:a05:6a00:2ea2:b0:68e:36b1:3d7f with SMTP id fd34-20020a056a002ea200b0068e36b13d7fmr2800436pfb.18.1695215729349;
        Wed, 20 Sep 2023 06:15:29 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id i15-20020aa787cf000000b00682d79199e7sm842560pfo.200.2023.09.20.06.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:15:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8A73A81A3119; Wed, 20 Sep 2023 20:15:25 +0700 (WIB)
Date:   Wed, 20 Sep 2023 20:15:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     bugzilla-daemon@kernel.org,
        Linux Power Management <linux-pm@vger.kernel.org>
Cc:     Huang Rui <ray.huang@amd.com>
Subject: Re: [Bug 217931] New: amd-pstate lacks crucial features: CPU
 frequency and boost control
Message-ID: <ZQrwbYJIh4vSzoGT@debian.me>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DTbjpoFRF6cZRe3A"
Content-Disposition: inline
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--DTbjpoFRF6cZRe3A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 11:06:51AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
>=20
>             Bug ID: 217931
>            Summary: amd-pstate lacks crucial features: CPU frequency and
>                     boost control
>            Product: Power Management
>            Version: 2.5
>           Hardware: AMD
>                 OS: Linux
>             Status: NEW
>           Severity: high
>           Priority: P3
>          Component: cpufreq
>           Assignee: linux-pm@vger.kernel.org
>           Reporter: aros@gmx.com
>         Regression: No
>=20
> Created attachment 305131
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D305131&action=3Dedit
> Power Options: Processor Power Management in Windows
>=20
> It would be really great if amd-pstate had a feature parity with acpi-cpu=
freq,
> namely
>=20
> 1) Being able to set operating frequencies (maximum, minimum and user-def=
ined)

ondemand, conservative, performance?

>=20
> 2) Being able to enable/disable boost

What is boost?

>=20
> Currently both features are not available and frequency control is simply
> ignored (bug 215800).
>=20
> Rationale:
>=20
> 1) This is required for benchmarking and proper temperature control. Boost
> frequencies are subject to multiple limitations (power in watts, amperage,
> voltage, temperature, BIOS limitations) and can change depending on the
> workload. Setting a low enough frequency allows to run benchmarks in the
> controlled environment and get proper data.
>=20
> Windows allows to do that easily, see the attached screenshot.
>=20
> 2) Disabling boost is an easy option to subdue operating temperatures tho=
ugh if
> the previous issue is tackled, it's not really needed.

For example, after compiling the kernel one needs to cool down system,
right?

--=20
An old man doll... just what I always wanted! - Clara

--DTbjpoFRF6cZRe3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQrwaAAKCRD2uYlJVVFO
oxVMAPwKg2C7JklgsJJFRt93nsjdqh40sJ9K2YhB1bRU0PcsXQD8CluOsiobJocu
XhIL//4C7Wxf8bOmZaT4dfENRKwDVgo=
=tI8Q
-----END PGP SIGNATURE-----

--DTbjpoFRF6cZRe3A--
