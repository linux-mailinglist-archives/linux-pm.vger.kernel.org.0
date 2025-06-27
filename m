Return-Path: <linux-pm+bounces-29705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B80AEC059
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 21:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EFF1C257E6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB121ADC7;
	Fri, 27 Jun 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSp31Htf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0501212D97;
	Fri, 27 Jun 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053679; cv=none; b=dW+b2eYUcoWFdkuL9CNNurpmr4lbXIcgMFywUOfnNsoRo+Fs4dzjYVfc13+ORLRPcKzxx1oWw97jDvNTFJBv3cbY7ZeEDylLHd5gfsILbGl2wEh1ViI9vs8i9pTh9K5az2jBDE0dXMTxKa2TrSUt7MSCBLBRtlwUdEVX2RvNIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053679; c=relaxed/simple;
	bh=qSFxmn8zMD2j4jiMzR4R/375FMeVfeiJxiC4gUPGm7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsUwpk5uA4yD1+ouDsgjMopg/lBCaZYSnXeznTsPv4G0DQqmPslKNz3zIJ+4wyDWefbH3A6w2e2IpBH47j2VWclYC6QWLjigW1Z6HNUAWsoV1cOEdWb59s0ByXPonnq3YMbCJxY+dQS859vGksPoYCpsmOYDta/aJMd5OGjtOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSp31Htf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CAEC4AF0B;
	Fri, 27 Jun 2025 19:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053679;
	bh=qSFxmn8zMD2j4jiMzR4R/375FMeVfeiJxiC4gUPGm7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GSp31HtfQLnBral28TfLQvRx010Epl9hR19y9111ibsCt/UwddvdsJKpVOtQo3ZZP
	 BJwaZWRLE5rrfOiJf1F6EEeJDX7SNf5PZsVv7woUUG9GHPNH3Q/e8kFT6/LTmfRlBZ
	 JLDfMi5/q0/tVRF/bC0NT6qCbWq9pH2SQL/wy54MFI9tvwIVvvYhd6dS2+E2flnRWG
	 HQ4c+8sQVFWVaVUv3EZqZ75JWV/eo/05/BZ8B5Bu1H9FhQLShPQuQc7vOTUFuFIcRd
	 GbklTYnPOb0cHVXarxyWmTmxWbl0lqAbDFoQReYaX6IVcTfQ1vvDnPr3CEwTL71qAl
	 tOMbfnfsBZkaQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-60d5c665fceso110061eaf.1;
        Fri, 27 Jun 2025 12:47:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0NrW2KwqnapqG7K1tXPrjkLjSkL3UUpNbk+m3tLpc64gEBl7vZHSI9244SXx40cwfK0HYz3h6PCD9O3c=@vger.kernel.org, AJvYcCXTCds3OyW6PEuNOQfoSpqjzoZKUx1pI7IJXGsNuytj2fw40KYw4NsLEo0BeLuGVjwOaBejkBXSs28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwetXws20+kip/HtsDsycJfcueZprLxESYEBNkd9XPNusArWCRB
	D6ZkB35HqWb7n+F2traEt/eXyAxx+lZ4kPlbYCCC6VfxzERlFHod3KoDyZK9iwH+7XIv2qHT5ar
	hgwyQlcINjsQ2uZkOMTVD1/vQNINzoTo=
X-Google-Smtp-Source: AGHT+IFIdkTX35vYH56ZqzJMeHfewRj+zYRHyAze0G05YjdlyfHn6jVAJqRX6vVYzK3qxXdFZTewgDanf1gfQlSQA9I=
X-Received: by 2002:a05:6820:4de7:b0:611:9fd4:ac26 with SMTP id
 006d021491bc7-611b911d923mr2696321eaf.5.1751053678537; Fri, 27 Jun 2025
 12:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625020522.253548-1-rui.zhang@intel.com>
In-Reply-To: <20250625020522.253548-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Jun 2025 21:47:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jVbc76E0jJA7S4N1xN1ESjuNO0xvfGk9wqDwNVOzBVkg@mail.gmail.com>
X-Gm-Features: Ac12FXyGNoB1Z0y_1SWfLTkjesRNP8aP5qzLamzRDvOc1UvafelIKdzPm3sUnPM
Message-ID: <CAJZ5v0jVbc76E0jJA7S4N1xN1ESjuNO0xvfGk9wqDwNVOzBVkg@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl_msr: Add PL4 support for PantherLake
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 4:05=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wro=
te:
>
> Add PantherLake to the list of processors where PL4 is supported.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> The PL4 support for Arrowlake-S and Lunarlake are also missing for now.
> We will add them later when there is a real need. I'm also checking
> internally to see if it is required or not.
> ---
>  drivers/powercap/intel_rapl_msr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_r=
apl_msr.c
> index 8ad2115d65f6..4ed06c71a3ac 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -150,6 +150,7 @@ static const struct x86_cpu_id pl4_support_ids[] =3D =
{
>         X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
>         X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
>         X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
> +       X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
>         {}
>  };
>
> --

Applied as 6.17 material, thanks!

