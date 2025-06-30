Return-Path: <linux-pm+bounces-29859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883CAEEA00
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 00:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C353B6EC5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A117242D71;
	Mon, 30 Jun 2025 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9Imj+mO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E57A4C6C;
	Mon, 30 Jun 2025 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751321388; cv=none; b=S13RAIJVA/lnejSW2k2yuFW4Rye8rxzPVQ06/l6l959QqJoObHgMYkG2jlD520ucbgv3ufW+V67u3ahuMxaRiZZuQdF2nmjuOGQz85e8kxnT1cBgZog/O2V55HPykEgtG7EtByTpisfaNddcZ08OK9vrZN1Ioid9srrnScOWWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751321388; c=relaxed/simple;
	bh=vAzj++/jV6VTrg7u4E0pCrASorfa+yLITSBpP77hHl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0fD01PbfRfrt1ddFn0jeOPvkHl81PlKuBf9RHFqpyUiGAFmdZj+/4b+taB0j5pIG5W4ZtY6XT39kSxXyLi+Y5IAvfDBBtw37eFWfev+m84lkFa4huEeupKrN0FySoa90hxRkL0WWMzzzfepK7htI3j5dXNJ1SeU9KlvHcg8d80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9Imj+mO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF04EC4CEE3;
	Mon, 30 Jun 2025 22:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751321387;
	bh=vAzj++/jV6VTrg7u4E0pCrASorfa+yLITSBpP77hHl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9Imj+mO/QgIz7SWK0mNab70Z88CDunmh9M8KADNqYvlLnFC5D2BgSIDrHE9BtLv+
	 /aWq8MzPF3+mScKk3EM0iovaOf6RkMGgeOv265jMuntlojLdfQB4Qpv4xg1f6CECAg
	 62udJlHcZTiq4WYezlr4S2HrEkEi8Of515lhBiZ3RVjF0UWVUW4tJ4N5vitRntRdSj
	 k7JtULNJN949UaHL45oSdzQAcBXqETd1kcPLWL6m/CKfWCX0WrTA4DzUvw7nacI3Lt
	 qxhuWOuPcc7eRXnYIgDHGJa0nUg3s61vaIJ9sSPC3QJjhRF1fCh5wtzT4S1QfIndVN
	 dc0uooeHkQzeg==
Date: Mon, 30 Jun 2025 17:09:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, krzk+dt@kernel.org,
	y.oudjana@protonmail.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, mbrugger@suse.com, fshao@chromium.org,
	mandyjh.liu@mediatek.com, lihongbo22@huawei.com,
	ulf.hansson@linaro.org, wenst@chromium.org,
	linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [PATCH v1 11/13] dt-bindings: power: Add support for MT8196
 power controllers
Message-ID: <175132138645.3512206.17376450738040159326.robh@kernel.org>
References: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
 <20250623120154.109429-12-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623120154.109429-12-angelogioacchino.delregno@collabora.com>


On Mon, 23 Jun 2025 14:01:52 +0200, AngeloGioacchino Del Regno wrote:
> Add support for the power controllers found in the MediaTek MT8196
> Chromebook SoC.
> 
> This chip has three power controllers, two of which located in the
> SCP subsystems (where one can be directly controlled and the other
> can be controlled only through the HW Voter IP), and one located
> in the Multimedia HFRP subsystem, controllable only through the HW
> Voter IP.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../power/mediatek,power-controller.yaml      |  4 ++
>  .../dt-bindings/power/mediatek,mt8196-power.h | 58 +++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 include/dt-bindings/power/mediatek,mt8196-power.h
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


