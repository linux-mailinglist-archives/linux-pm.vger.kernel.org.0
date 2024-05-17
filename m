Return-Path: <linux-pm+bounces-7935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8D8C85A7
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 13:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D021C22B9A
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 11:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2F3D546;
	Fri, 17 May 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSDax32m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AA3D541
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945196; cv=none; b=pybFeffDSC7Zf/fiW6Zrl1Q2YDskdAEHirM142bbNNfayRR9WlCcu4OvAa1J7r+pmUPjIh56y0DkNcKYAcRAPagjaajC9FwdV9h49zyFC1ryxPF1T154cwC+RfwHL0BJoULilVGF8KMbNxSVWafta/W62KPGfdvM6JeuZh7IFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945196; c=relaxed/simple;
	bh=ZGv4lo86XZ5749oXmsMARbzxe2r3budrQ1NcMc5bO+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLK8A29oW8dRyjCjfLn96gkyPno8yeby7tT8OgYy4OWnDAJIfC3WqNOI7e7i1bIdDepBUreOx/LDVUTboK8/6MZ6kT+ur8gP+SjTHJ8XXpaJikp8zNyidXUzFx/snCO3sopMfN0QDbIUE6e8bgjJpLLDHDF6pPsI+0R+KJx1wg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSDax32m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFA2C2BD10
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 11:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715945196;
	bh=ZGv4lo86XZ5749oXmsMARbzxe2r3budrQ1NcMc5bO+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FSDax32myLsgbr8yi7C0CmLn2DVWiMSL3njmsptFIB8NKeTGAPFrY8FX6MnjGnHfV
	 oeaJWF8UIlwHWwjh1jrWudreRHybsQbL6MU9H8qMDhS4JqvWVCr56qbKJtCvNWO2RZ
	 6ftqZmQPwysY98tr3KNEp/FpTwp6r2c3owlJsyRYgPKIJNdNWT4x3APuoxPfDlaBDp
	 cRkDnT3QnWDX3TzY95rw30cBpGzkrc9x6Pr7UuLBNiNs+RzXUCXPik55vi/PwtgIHB
	 2SPoM8I6vayUvnD/iv3ShB80gMNLJzKs6tC4g2WyovK45lp2+LY3jVUGVvHsncl0GL
	 O+g6NpSmd5kGA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b2f2a584c6so5312eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 04:26:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmyn9eU+gxi7sHWVASTr0MAoSKBm+yoPf0Ro/owtNAezdOC53WmFS+znXCEH+M9KVEOklFo4rCBAFMRzhETsVohGNMegfcIMI=
X-Gm-Message-State: AOJu0YwEsZwgXZK22YTozSILudipvocoEiLrb2A2/1145DdNh3hk7stf
	xKdb5RdXWSVkp0Yvwp/dFfsOjVrWIk7R0y3T9kqSD313aI9Hk60zQntO6H9z/Xzn8UJJUgkVqtV
	r7gwS91RI6T+fpRc8VS9uVWqgZFo=
X-Google-Smtp-Source: AGHT+IFDEMCh0z/qYa1cIf21xJLG9pK1Z0yAAyN6R8R6BE2Bse08DRCZ7eiaNvLoPj6D43E0Om5sL6QNVx7XgHCNJAI=
X-Received: by 2002:a05:6820:2881:b0:5b2:89f:452 with SMTP id
 006d021491bc7-5b281962379mr21693911eaf.1.1715945195299; Fri, 17 May 2024
 04:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517103440.p7tlrthhy4mc6n6o@viresh-thinkpad>
In-Reply-To: <20240517103440.p7tlrthhy4mc6n6o@viresh-thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 May 2024 13:26:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gmLGuV=7xCrZ2cH-67MfjDWBO=oNzmtBCiTmV4M_6R2Q@mail.gmail.com>
Message-ID: <CAJZ5v0gmLGuV=7xCrZ2cH-67MfjDWBO=oNzmtBCiTmV4M_6R2Q@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.10
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Fri, May 17, 2024 at 12:34=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 4cece764965020c22cff7665b18a0120063590=
95:
>
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.10
>
> for you to fetch changes up to 2a56c462fe5a2ee61d38e2d7b772bee56115a00c:
>
>   OPP: Fix required_opp_tables for multiple genpds using same table (2024=
-05-17 12:22:46 +0200)
>
> ----------------------------------------------------------------
> OPP Updates for 6.10
>
> - Fix required_opp_tables for multiple genpds using same table (Viresh
>   Kumar).
>
> ----------------------------------------------------------------
> Viresh Kumar (1):
>       OPP: Fix required_opp_tables for multiple genpds using same table
>
>  drivers/opp/core.c        | 31 ++++++++++++++++++++++++++++++-
>  drivers/pmdomain/core.c   | 10 ++++++++++
>  include/linux/pm_domain.h |  6 ++++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
>
> --

Pulled and added to the linux-next branch in linux-pm.git, thanks!

