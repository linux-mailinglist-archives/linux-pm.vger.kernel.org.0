Return-Path: <linux-pm+bounces-5156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A638814A4
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 16:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828AE1F22853
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2978524C0;
	Wed, 20 Mar 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewTpx6kC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73BD2746B;
	Wed, 20 Mar 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948765; cv=none; b=sY5nABrr06LMDPwngP5qXP5Jw6rQwLEF23mFBIhLUaK7UeMNDXpbPsg7LySsNpaQBCLnrCsT6kTj1v4Ol+hCqniRaOx0H6BXqsB3uU/V1/1eD184ZqMTqehfImXY5zpDgujhxnA3cCaElQNnkNCajSm3dAbDZWIi/NoWkVCu0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948765; c=relaxed/simple;
	bh=gW3iHwL4OWAxkaSXv/fLpVs36bsMw/9vOSHOFPiRlUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzThv58aNeIkB9eYY3Xperxop+huUjO6p7m7q6fdUwFHsF+PUnS0odB3AKEB/dpHvcYjkwec352jtzEzaTbf6Zd+u8FXAhnkhHfhx6JSgX1Jy4ZKp74Lk/raTxTibRil+qBBtUjhnsiXYYwep6iHVJZggUTLwzNnJxpjfRo8Zok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewTpx6kC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5AEC433C7;
	Wed, 20 Mar 2024 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948765;
	bh=gW3iHwL4OWAxkaSXv/fLpVs36bsMw/9vOSHOFPiRlUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewTpx6kCQIMQuWQNuip44aS/k7lJIMqTiEj9UOPx43aH9Nd0OmHYWU+mOBZH8nVA9
	 dLoBXoNPNTIoOS1J9X+5BhUhI2VQI63jjqJoqStvODbguWvZyEVdxBvJi9FDx+Ws0P
	 7NvUjIpd3sdPb2G1LAxyDeP9nYMZvpSnfaDjFhG80+N/05JtXcWDdO+sLNObEUrOdo
	 YKDZcg23PY8q8whhdr0ZeLixnv/+R51kgnCDJstwzhdy1pRXA//dlLvJGvMlgu+DEq
	 2titbGOcS4MmYEiK2g8w+Uq98ns26ZqsvN9Akp9s6ZSg4PaZ5D29ky5USpA/JSNsL0
	 edkWAqRLvnMHw==
Date: Wed, 20 Mar 2024 10:32:42 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH v2 01/13] thermal/drivers/mediatek/lvts_thermal: retrieve
 all calibration bytes
Message-ID: <20240320153242.GA1760306-robh@kernel.org>
References: <20240318212428.3843952-1-nico@fluxnic.net>
 <20240318212428.3843952-2-nico@fluxnic.net>
 <7a529bd6-abac-42d0-980e-3b1b5c46946f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a529bd6-abac-42d0-980e-3b1b5c46946f@kernel.org>

On Tue, Mar 19, 2024 at 12:40:20PM +0100, AngeloGioacchino Del Regno wrote:
> Il 18/03/24 22:22, Nicolas Pitre ha scritto:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Calibration values are 24-bit wide. Those values so far appear to span
> > only 16 bits but let's not push our luck.
> > 
> 
> I wonder how much feedback you got on v1 - I didn't even look and will not lose
> time with that - but regardless, if you don't add the right people to the Cc field,
> I really don't think that you'll ever get your patches reviewed (and probably also
> not accepted).
> 
> That -- especially if you don't even Cc all the relevant maintainers...!
> 
> Please read:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> P.S.:
> scripts/get_maintainer.pl lvts-8186-8188-patches.patch
> 
> "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
> Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL,commit_signer:21/22=95%)
> Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
> Lukasz Luba <lukasz.luba@arm.com> (reviewer:THERMAL)
> Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE
> TREE BINDINGS)
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS)
> Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC
> support,commit_signer:4/22=18%)
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> (maintainer:ARM/Mediatek SoC support,commit_signer:13/22=59%)

> Alexandre Mergnat <amergnat@baylibre.com> (commit_signer:11/22=50%)
> "Nícolas F. R. A. Prado" <nfraprado@collabora.com> (commit_signer:10/22=45%,authored:7/22=32%,added_lines:128/453=28%,removed_lines:45/98=46%)
> Balsam CHIHI <bchihi@baylibre.com>
> (authored:4/22=18%,added_lines:235/453=52%,removed_lines:22/98=22%,in file)
> Chen-Yu Tsai <wenst@chromium.org> (authored:2/22=9%)
> Minjie Du <duminjie@vivo.com> (authored:2/22=9%)
> Frank Wunderlich <frank-w@public-files.de>
> (authored:2/22=9%,added_lines:72/453=16%,removed_lines:17/98=17%)

Please don't suggest to people that commit signers and authors are CCed. 
That results in huge Cc lists of people that probably aren't interested. 
If they are, then they should add themselves to MAINTAINERS.

Rob

