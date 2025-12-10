Return-Path: <linux-pm+bounces-39400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BF5CB27B0
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 10:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820DE300D413
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9CA28934F;
	Wed, 10 Dec 2025 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="qodHpl4s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1D1A724C;
	Wed, 10 Dec 2025 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357427; cv=none; b=r0rjrSHonlRulNv2nq28Jj+uNPMx6JjihqVZ2iBq+4E0tgf92mP+EyVCCh+d2lsIK09fcpZKTM5G5+P6UNv7oRd5/q/ifrGOA9WXtJtKbl6A9nhe2VvrVB5/YJW5Gsgc2AHp3SboCpLnfx8mor/kjDZJEZfqT3XuH2xuWDRr9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357427; c=relaxed/simple;
	bh=+o6mbVgJFTXivMQqKUFA1Xz2Hdad1XRAS2GVVF+0+o0=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=eTb3hn3ia/lcNNlK0xh8we5SV0i0eUxB0ISq7cgJD17aVOwZ9KpyvJgah/p8YCtZ3ok75HRgSyN1qWDgdygcjUpMBC6LGh5Az+T0hFE6KiQjBbuah5gwyFRTK4OUOEfTEIjTnMTtlyqtkumP1HxGYR/Zy8Zf/9lQhut2Jsx6z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=qodHpl4s; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 863FF13957;
	Wed, 10 Dec 2025 10:03:36 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id 7ZfK-wxiiX5w; Wed, 10 Dec 2025 10:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1765357415;
	bh=KdK6lC5r121QNCLORrS1blZX3VYEoPUfyGWLtVLeS9I=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=qodHpl4sHFd79+myXiqtcYqK75ROTNIxQDiwcdLjHOfRfxHBTxni85S+vJh8LJtDf
	 nCNk1rpCfRPFtjH1l8+aPkBWSI7ezyci3OYprvvgstpPlAbHK9FtacnDysWqalJxp2
	 gg2m6X9Vpk5bOL2M4G83WX8LsV0dpGJpBV3nV8/bIPLpuE9h2ay3zZ6nMotVIMJFZn
	 EPSNAHHAzpBMvVjSGqGItEp57MaGMjqa7/0O0SBrlEx1yaim4grTM9e80oXFD6Ck//
	 25FAdMNKq+29mNjjQlh2QttALJPv6uFe7CrX5CFvgGBLg+HixbBWcNsVywJf2xbJE0
	 ndbZfQPg79/Gw==
Received: from [147.32.86.141] (unknown [147.32.86.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id D7E5613AC5;
	Wed, 10 Dec 2025 10:03:34 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt-platdev: Fix creating device on OPPv1 platforms
Date: Wed, 10 Dec 2025 10:03:34 +0100
User-Agent: KMail/1.9.10
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20251210051718.132795-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251210051718.132795-2-krzysztof.kozlowski@oss.qualcomm.com>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202512101003.34566.pisa@fel.cvut.cz>

Thanks much for the fast response and fix. I have run checks
successfully without revert 6ea891a6dd37 and this patch applied.

On Wednesday 10 of December 2025 06:17:19 Krzysztof Kozlowski wrote:
> Commit 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with
> of_machine_get_match_data()") broke several platforms which did not have
> OPPv2 proprety, because it incorrectly checked for device match data
> after first matching from "allowlist".  Almost all of "allowlist" match
> entries do not have match data and it is expected to create platform
> device for them with empty data.
>
> Fix this by first checking if platform is on the allowlist with
> of_machine_device_match() and only then taking the match data.  This
> duplicates the number of checks (we match against the allowlist twice),
> but makes the code here much smaller.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes:
> https://lore.kernel.org/all/CAMuHMdVJD4+J9QpUUs-sX0feKfuPD72CO0dcqN7shvF_UY
>pZ3Q@mail.gmail.com/ Reported-by: Pavel Pisa <pisa@fel.cvut.cz>
> Closes:
> https://lore.kernel.org/all/6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxb
>jys@rmwbd7lkhrdz/ Fixes: 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with
> of_machine_get_match_data()") Signed-off-by: Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
on AMD Xilinx Zynq MicroZed xlnx,zynq-7000 platform.

As for the initial report, I have located addresses for CPUfreq
maintainers from the mainline MAINTAINERS file - Rafael J. Wysocki
and Viresh Kumar and PM list, I have added Michal Simek as AMD Xilinx
platform maintainer. I have done quick glimpse into history and have
seen some recent patches but have not time to do bisect so 
I decided start with some maintainers the first to not spam too much
people. Then repeated to the already extended addresses list.

Best wishes,

                Pavel

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

