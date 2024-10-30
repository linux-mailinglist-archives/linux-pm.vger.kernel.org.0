Return-Path: <linux-pm+bounces-16765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB39B6D72
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 21:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CD71F21186
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 20:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E541D1519;
	Wed, 30 Oct 2024 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elEe2qxl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA6E1D14FB;
	Wed, 30 Oct 2024 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319287; cv=none; b=B1x09+3rII6DopXlIMf7cwongSHpXwOtbmPJzsmvIzv9wW/RgV7VOAk2aekWRgurgVF1ZCaUvz7qje4VMSQzdX+zUvbgB/UTbfUJ+z/xy4XYsr7NpVmOtrnKYmTXx0YnMAFjaR8GOKyVE++J3+paPD8jNrXwxXsYLShpoNdFN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319287; c=relaxed/simple;
	bh=6kxVpaFI1ZML7mVp1gWGnEfSVv3OB1JV0EJOz3Ivvj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT+2lFAPqDQW3WmTW+vvTrB8ZeIGt7XiETczZpf/n+TZeSm3W5NWuWmL7/hI7GGrYb9LLhRwDFeiYeofRGGSpu/BEq45ytPXs2MHHI8u0McagxFv9QCi/ZhSmgtcOkaoL8Jf3lx94Bb60SOBsh9ObeGXlHICp9v1cxQjGTmtXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elEe2qxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EB9C4CECE;
	Wed, 30 Oct 2024 20:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730319286;
	bh=6kxVpaFI1ZML7mVp1gWGnEfSVv3OB1JV0EJOz3Ivvj4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=elEe2qxlq/tq9yHVtICkU2lMPx3AKZPDGcaCzpQ7lbK6uJS68eiXV0qTOTtlnarL5
	 erP7oaQQoLK19f37F2TbQwPB43Iw1jVfTTNm1QoRsl5EOymgCzXRkps3lxNZz8iwtQ
	 rsHQLKTYxtVnWNhZZ/YLpnKqEUXB2CJKtctZyBYskdN7ImSTwixNIS57Yze+7Jfi2J
	 EtEDgwjN4PaO20L6rqo2d6Nq3QyrXHZDtf1iEIywuhn9WNcHdNmJmGXnTT0+GspXR9
	 VCvy/y5sZWLILWrBYvblwk031i4Gq/bV/R8agNZUCsjHRAbqPnSpxKN8WcaFXzIHSg
	 TJlA8ICMqNfJA==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71808b6246bso103843a34.2;
        Wed, 30 Oct 2024 13:14:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4S/1OJVexEGXd/xbz5OanmSoW83c9m4yN7TQ1elaO49KSSIhPxeoLcSexCJxif47Idda5B7gcnH2HTnE=@vger.kernel.org, AJvYcCXv+MkL1uHABnCjWkY45HqHyvZnUpF9Pr0fxRUJpjVPUoB0/pAR8mfNIfMCCzI/GsdZ+pikhz2lvlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzvabN2VqPpn4Vx+5wrNvWej+leH5rUGMsFxDmg3FOtZAznBP
	FBVkhOhYuyHVslhcQ4i2VKBAFFZzgYDpbrjROt8zZOWOOu/iVNfO3JeiDSWmQqR4+7R2eWM+rTt
	2o+JKxFz22EGUA7oZl57eLF8R8fU=
X-Google-Smtp-Source: AGHT+IFegsDhcZQhn1bpNLDBz9XYx6v4gPhpqyRTrfwgyFhSpal8guopX09XxBD0DtFK+0WxmcPqfziQ5bFgfMx/ui0=
X-Received: by 2002:a05:6870:b50e:b0:25e:24a0:4c96 with SMTP id
 586e51a60fabf-29051b73021mr15841177fac.11.1730319286119; Wed, 30 Oct 2024
 13:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
 <20241029101507.7188-3-patryk.wlazlyn@linux.intel.com> <e332a243-5a98-49ed-81be-b6db305d5dc5@intel.com>
 <35946efe3b8b8b686ba4ea0ed5c9f15c50ca6ef8.camel@linux.intel.com>
 <000fd68e-2b24-4eb3-b2d7-e4856b403212@intel.com> <CAJZ5v0j+Qc+5PtPdsDy5B0iAGWOxYbKdUOkVmL_jPNVO8fNK=g@mail.gmail.com>
 <b01cc6de-8440-477a-9844-d921da9dceb7@intel.com>
In-Reply-To: <b01cc6de-8440-477a-9844-d921da9dceb7@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Oct 2024 21:14:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gD+QjuW6iiJS7M0H_BAdXH7tnDGa+hp5BnvSNF+Cb0aQ@mail.gmail.com>
Message-ID: <CAJZ5v0gD+QjuW6iiJS7M0H_BAdXH7tnDGa+hp5BnvSNF+Cb0aQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/smp: Allow forcing the mwait hint for play
 dead loop
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 9:11=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 10/30/24 12:53, Rafael J. Wysocki wrote:
> > clearly referred to as a kexec() hack, which cannot be done in
> > cpuidle_play_dead() because the cpuidle driver doesn't know how to get
> > to md->control.
>
> What if we have an mwait_play_dead() _helper_?  It takes the hint as an
> argument and retains all the kexec hacks.  All the cpuidle driver has to
> do is call the helper with the hint that the cpuidle driver determines.

The same idea has occurred to me in the meantime, so yes, I think that
it would work.

