Return-Path: <linux-pm+bounces-20140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBF0A074DC
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 12:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8438D168531
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9463E216E37;
	Thu,  9 Jan 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDLPsUqv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516A12EBEA;
	Thu,  9 Jan 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422731; cv=none; b=d99sEI3Ge69kT516T3Rn++nDbF9t6r/wGa/rjirdeCTZPQJVAzyyVJdbRG9IqdqQb46Q+gTbOiLGOLclX3koOnT5wES6QcRAeWAoBVkC0zLNAV5IKdMApMXWBmMnQadmB+M+1ZP3xBuqLNu7cvSt1PjEwJd3I28awMENAVpB3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422731; c=relaxed/simple;
	bh=zgMHsOc6QOK1ad1fReClnAUKTbMQiY82oCo9qlKQvcY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GkShBIPeHSABnkQfD871qNw+msV6myo+jKQrRUSEKKRzrPf72e282IRfp6L0jqANcXnQ0KOBE9/h81XfBDIJBJhI9nXU/sUp4kwfM7jZ9CDKGvPnOz28mTm4FkQ0zO6o6dfP9w96U3krWmxzXyPQFvt7Mbro1kdhhPiimtT6Hw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDLPsUqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222D5C4CEE2;
	Thu,  9 Jan 2025 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736422731;
	bh=zgMHsOc6QOK1ad1fReClnAUKTbMQiY82oCo9qlKQvcY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vDLPsUqvdItIFevZ6ywY6qN1aTgNp61+EE5SyRAssptWz3/DM6/MItnpCrN9VPQwd
	 NoVPkRfGWobB3MlKtrme0mhKm5KzhL/E+psNe6rCbb6POAxpK2LN1XP7zuh6a8JXTe
	 ce2Pt463WiTBddkLN5F1liBVDwNANcpWkDrXSfRgA8VMW/C9I59Cy5wiLkGRoa2fPX
	 BLvtiW7s72ebafPI0rUNcYPo7OMVv3boXQSPs+mWIOIrb7dcayHGAkx5o1yzBy0ZiE
	 Uq+cmgFQEYMkpDLIx9XZ+xn9Dot05j83nc03nrFncvX8+/DvzZ3uGgL3i1LfyUdDIQ
	 NEqCH0bzeGAEQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250108164359.2609078-1-andre.przywara@arm.com>
References: <20250108164359.2609078-1-andre.przywara@arm.com>
Subject: Re: (subset) [PATCH v2] Revert "mfd: axp20x: Allow multiple
 regulators"
Message-Id: <173642272888.2620575.17634288216154119464.b4-ty@kernel.org>
Date: Thu, 09 Jan 2025 11:38:48 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 08 Jan 2025 16:43:59 +0000, Andre Przywara wrote:
> As Chris and Vasily reported, the attempt to support multiple AXP PMICs
> in one system [1] breaks some of the battery and charging functionality
> on devices with AXP PMICs. The reason is that the drivers now fail to get
> the correct IIO channel for the ADC component, as the current code seems
> to rely on the zero-based enumeration of the regulator devices.
> A fix is possible, but not trivial, as it requires some rework in the AXP
> MFD driver, which cannot be fully reviewed or tested in time for the
> 6.13 release.
> 
> [...]

Applied, thanks!

[1/1] Revert "mfd: axp20x: Allow multiple regulators"
      commit: b246bd32a34c1b0d80670e60e4e4102be6366191

--
Lee Jones [李琼斯]


