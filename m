Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D5E22227C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 14:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGPMhV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 08:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgGPMhV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 08:37:21 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C3FC061755;
        Thu, 16 Jul 2020 05:37:20 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lx13so6400772ejb.4;
        Thu, 16 Jul 2020 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AocC3N5O0Uik9tYTa8moQI4LJJ7GiuwBhVnoPAOMLg4=;
        b=dxAyHGv8/TE10lSjw/yQqwJGeZjjI08Ao3yIohI6bXl91J5ofEmcPmLjm3VjQSFfHg
         Jttj08hfnGuNsqTPObfYq4diqcl7Fa9pii54JJUJLL6l9596OD7u1/vw8Z1pTfNSTlwF
         aUJWF66b4GontU6xmfqKV7uywwkFNntXMS384rkFPOWQTyCaF51q6nJhNN0Saxm+a+06
         xv3IdB7VSqksw/GzwKUE5MT6InYFiyAtcso5/IChhux6pqAtKzORkEWEpYYM8dAi2/8A
         1iE0P488pn8eWgn65AIuyWIMiIYcq8soFEbpimPROSh0uMVpVJlvvVlfUgnVvnXSCipD
         F+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AocC3N5O0Uik9tYTa8moQI4LJJ7GiuwBhVnoPAOMLg4=;
        b=W6cimUG7BuJimtX/p2jWlmew8r1SYcoGxo5y8l0PIJxDeCmt00euP3yT6+wfDJj0WE
         AjuErXIX1w37qVSkI3s9MkIpvnLtJK2yW66rD1jLSH/Ie4vp8E6ajDeKr69i7ypzjod2
         F6bsR0qr7BJU967sgChgrxl+QVQOp+zcPlWfwMJTfVJS5STZBXgKj8RFr/dkbQhvTTwA
         KZcBPMRqS/rS3QT6xwqT0DTLIhnEXnWrySTkvEFRFnYcjN5W+8UihfaFFqA9ci2fhYoF
         FGYMV+VkJjK0fahlm0vS++v0zBVm5FBoI2LOJpHShzNtvVIxnZ7u9dlWHzxDCKrvckCO
         CNeg==
X-Gm-Message-State: AOAM531oMbEPej1GiR28UbZHNIRn2zHKL0F/tl29vRMWvwHcY3N3cCol
        FYiIvezyyPeWhmKDsoyceYo=
X-Google-Smtp-Source: ABdhPJxzzgoaNlh+vbjSbCGiMYEDZpuqnaxyDGO9u2TDK8GFSqsac269SAuIWYX7yVNK1iQ9KS/vnw==
X-Received: by 2002:a17:906:e210:: with SMTP id gf16mr3443029ejb.386.1594903039688;
        Thu, 16 Jul 2020 05:37:19 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id ay27sm5289311edb.81.2020.07.16.05.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 05:37:16 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:37:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        mirq-linux@rere.qmqm.pl, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v6 2/3] arm64: tegra: Add t194 ccplex
 compatible and bpmp property
Message-ID: <20200716123715.GA535268@ulmo>
References: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
 <1594819885-31016-3-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <1594819885-31016-3-git-send-email-sumitg@nvidia.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 07:01:24PM +0530, Sumit Gupta wrote:
> On Tegra194, data on valid operating points for the CPUs needs to be
> queried from BPMP. In T194, there is no node representing CPU complex.
> So, add compatible string to the 'cpus' node instead of using dummy
> node to bind cpufreq driver. Also, add reference to the BPMP instance
> for the CPU complex.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Looks like the DT bindings are now done so I've applied this for v5.9.

Viresh, are you going to pick up the other patches, or do you want me
to pick them up and send you a pull request?

Thanks,
Thierry

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8QSfkACgkQ3SOs138+
s6EbDxAAhqiTFGVj3wdEIaQIT0jcQR9+VZIbrzcT3Wob4TFu4TTP+vNGQj6zvqw4
sluL9jQ8fg43Hl/rR3wsxJvp9IqSqWOeIcI4cqJ3a4ztIC2jyqCL8NDbr+oaL3K+
k+teHfVv/VqluTyqJC0N9Q+0yOifuZ3BXSmbW8Mfh0VH5U0RX/sYW0Clzsa1dK1t
LJscfWRHRyoEIi+GVL+B8at7xK/vxP/LjIncFufO//LwAxqb0qm4HUmdixHLESDd
tnIlUoe2Cta8Q9ksQXsas+6hW7ykoDTlnfLVvJ3WmjBrJPhTMRwub7tglL0smQs6
KkP2d1cRmCeRIbJkcttClKo/poBGRsANiZrz97ljGujPNjJl8heCcYqdQhwvOvie
dw2Yv7vATSMxTv0qSBFUqFi7wfevvhRys3Z3qc4Br6o0VsxtR/dmaiOhxcd2xMSk
7e4bi9/g8NlljezdeI5L8VDj3Phjzho2ItYNFBP3CCLTZwHGVkVsymT+wvoN9TgF
rU24SGbvTP6/Op8gZ+Gm/CeVuYfYaZ7mRhp0XZVy1Gqw4wnpiVp7/+cM5EIXQTFt
1tN5+WpPlmH9WDLVWfo2lBKekw5om++Xpvpo7WlVe7FB66XcNtyecmXYWa8SzQQi
OCFGLe9PDlxfWR6Vi4TIZ5yhLkiaszewktYYt+fo6v8tUaRyxw0=
=UgfU
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
