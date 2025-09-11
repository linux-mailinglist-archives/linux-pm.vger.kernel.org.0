Return-Path: <linux-pm+bounces-34494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96296B538DE
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 18:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55544177443
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708A935082D;
	Thu, 11 Sep 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIklWWxL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A033EB0D;
	Thu, 11 Sep 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607236; cv=none; b=DA/YTI001AzTvrnlsfdnc/JDiM+JcVwtR93jBIBoZYN8V79DOpQ2pBawvflp0cyFAVm8cW02yqY8SrH+KZrnu8nlqoZ3NbsJUOr1fKvCEUVymTF+IFzmS+FZ+IVrX6Ao3mnGxp7/I1xaq3aPlFTBIxsHJaf4Socir4lEl36DpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607236; c=relaxed/simple;
	bh=I/2VPogFUvAPdDxRFIzXXpfzHkiezzIR2cEgbm5BxTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFg1mnxObpPLivuBXy2tDpo2qF99VMdrLIF9EyBl/S9bb7dxC5Ae1v8CMkuPe7Svk7TmnrWPTteUofEEnNsVYpMribyPcDnl5jXBMS5YwHv3OV3VI2z8X+xTR4cJgkQlVl7kP8hcIsNfKYeVcay4Vd/YhcR6eDaJyWmDmZZu0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIklWWxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D7FC4CEF0;
	Thu, 11 Sep 2025 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757607235;
	bh=I/2VPogFUvAPdDxRFIzXXpfzHkiezzIR2cEgbm5BxTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AIklWWxLHs+5NpFqBlorRZgi5BhtcwmNZObEe/fZXdq2iThoZEyCjY5S3sssk5QDk
	 c3cohzK700lOmf7SFRrvdgbc6Bgwu+gYJ5LU5kRTSDK6ux+FW8bugSSiM+lUloFJhw
	 LONa9ByGtu30UC6Ui7ZXobwq/7iKXrPfz/jucsmBdKz+UlOg6n06sYTaNz59pPFMX8
	 UFBOSMRYLcsBm7bjJLHegtUkDffD5l68fv4/57npS125s5mLOJkIDAia/jjJ6EsmBZ
	 3r7zmNNy2Yy95aDWPAgWz5w4Fm1UlHagI769HLAlVCvX5Mhj8azQ4bdlz1UIwLFEDp
	 cBVEh65woBzRg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61e74e59d8fso442766eaf.0;
        Thu, 11 Sep 2025 09:13:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVVl42/b6pPjjj+4SN32OvNgH07dsCwcN6yS/kM5FwoukoW7FTPGZbfBvgKXbN2fhFsn/5856Wisdt884=@vger.kernel.org, AJvYcCWXXpVyPmXfzvk2egmflRvpRdU+/4xfjRL+t2m2fpnyezHnO850TBOyMlFDf5C2UU68NfisLZKyLLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJu4Bl/lnl7aTCwuG56vC3u4wiFopAkYx2IhTluf8s/puzewb3
	f+YrQJEpJcMMZ/H6DeMzs/sUMrUTwniJWAzwZ72vg3hQWGRkBeYb9Tornzv22hHtou0WK2117BY
	xaSngQjJLQCV19GS1RXYJ22pUBdzzMdA=
X-Google-Smtp-Source: AGHT+IHOuAIfnm9DqiC/ZecQn8S6rKbOtnHBhA8LDng79PRBOOIOprC17snFIG++t0ONoKNX3cK9Tkt3WvNX1siRtpQ=
X-Received: by 2002:a05:6820:1627:b0:621:a69d:bafb with SMTP id
 006d021491bc7-621b2e8eddemr1759288eaf.2.1757607235199; Thu, 11 Sep 2025
 09:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <013e03cd-6d8d-4bf9-ba52-5001d10444b7@kernel.org>
In-Reply-To: <013e03cd-6d8d-4bf9-ba52-5001d10444b7@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 18:13:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hGXdEoA=xrxotvDgTgc47Fbe06z5OW1-9eJy0COBEfzg@mail.gmail.com>
X-Gm-Features: Ac12FXwwbRAC3Do5fEtZmyJ3Wo1ZbD0aqplbJ-TpIA9xbJxWntfykJjQG_cNGHQ
Message-ID: <CAJZ5v0hGXdEoA=xrxotvDgTgc47Fbe06z5OW1-9eJy0COBEfzg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.18
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 11, 2025 at 5:10=E2=80=AFPM Chanwoo Choi <chanwoo@kernel.org> w=
rote:
>
> Dear Rafael,
>
> This is devfreq-next pull request. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e=
00:
>
>   Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/de=
vfreq-next-for-6.18
>
> for you to fetch changes up to eddb5ba91b289faa15117d4fc1c2fb223f3493c2:
>
>   PM / devfreq: rockchip-dfi: add support for LPDDR5 (2025-09-09 23:37:39=
 +0900)
>
> ----------------------------------------------------------------
>
> Update devfreq next for v6.18
>
> Detailed description for this pull request:
> - Add support for LPDDR5 for Rockhip RK3588 SoC on rockchip-dfi devfreq d=
river.
>
> - Fix an issue where DDR cycle counts on RK3588/RK3528 with LPDDR4(X)
>   are reported as half by adding a cycle multiplier to the DFI driver
>   on rockchip-dfi devfreq-event driver.
>
> - Fix missing error pointer dereference of regulator instance
>   and remove redundant condition on on mtk-cci-devfreq.c devfreq driver.
>
> ----------------------------------------------------------------
> Dan Carpenter (1):
>       PM / devfreq: mtk-cci: Fix potential error pointer dereference in p=
robe()
>
> Liao Yuanhong (1):
>       PM / devfreq: mtk-cci: avoid redundant conditions
>
> Nicolas Frattaroli (2):
>       PM / devfreq: rockchip-dfi: double count on RK3588
>       PM / devfreq: rockchip-dfi: add support for LPDDR5
>
>  drivers/devfreq/event/rockchip-dfi.c | 91 ++++++++++++++++++++++++++++--=
------
>  drivers/devfreq/mtk-cci-devfreq.c    |  5 +-
>  include/soc/rockchip/rk3588_grf.h    |  8 +++-
>  include/soc/rockchip/rockchip_grf.h  |  1 +
>  4 files changed, 82 insertions(+), 23 deletions(-)

Pulled and added to linux-pm.git/linux-next, thanks!

