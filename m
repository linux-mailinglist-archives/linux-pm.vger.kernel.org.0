Return-Path: <linux-pm+bounces-31129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE1BB0B8B1
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103933B3463
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE122A7E6;
	Sun, 20 Jul 2025 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/X8Z+9Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA91A2547;
	Sun, 20 Jul 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050527; cv=none; b=AqEBpfaQxVvIDGa4fPWqAa8Cz/xaSd3HdFOu8NmeFnsdzscWS51MOAI8O/AIyKUKUqnILZ4UbOsRm3JICKfqbosGrtfL4GZABhUWYZbsgtW8nz9UoSW3odkpIJwKF8DWIavc0XBF+N2hFtd+Qvx23/mtQ29ODRdz0qvOcQPqGFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050527; c=relaxed/simple;
	bh=1eoLPf6ynvuzjLrZJv6wNDurB8M+vqGVwIM06bZvBgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVtWbtzy8q2VUwZsPX9XoQ3HGMsm0MgNlAjq/Yk6b724/CMXrxs3mRSUWLGlXqMP3gpacCS2nHcPweUfSvZ+YSYLAzeN2tXCpYNnRALGxq9loUcPZwAXHVSoJ3YlCAnbWBxJavn7kNDl9Ui/wCO3scT9S9rLk2kHEFmh/OFEt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/X8Z+9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3794FC4CEE7;
	Sun, 20 Jul 2025 22:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050525;
	bh=1eoLPf6ynvuzjLrZJv6wNDurB8M+vqGVwIM06bZvBgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N/X8Z+9YU7yOfD4sLNrH1icV03ppZ1qiltTr4YWrBRA6cbWFqhBnhJ1ouomdtf/68
	 J3AkB2bwDj7+5ZfajSrPtECGyrAyLL82lzFJmFuegcj1vjPWhcEDEoq667sLF1Ey6l
	 bz1pmbyEKV3m+UoQIgKMLgiwR69HjxDgcgRQd3MBsag/pBOW06BjLCZC8oY4vzi3dX
	 IsrJnl2OBMDBh3/r5Fva+hnCugtygqxrRUf4uoNAxGsVD5TWfNxM8tL4TJyJupgX95
	 AEZ46LbXjRIJTdMrhIEbktYGYe+6uPV7vXs/ZJWPefqbVoHxMAYvo083mT8UmorEvv
	 johHjqjSDnaNA==
Date: Sun, 20 Jul 2025 17:28:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-clk@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-tegra@vger.kernel.org,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	JC Kuo <jckuo@nvidia.com>, linux-kernel@vger.kernel.org,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>
Subject: Re: [PATCH 07/17] dt-bindings: clock: tegra124-dfll: Document
 Tegra210B01
Message-ID: <175305052408.2895244.11019731313205948430.robh@kernel.org>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
 <20250714-t210b01-v1-7-e3f5f7de5dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-t210b01-v1-7-e3f5f7de5dce@gmail.com>


On Mon, 14 Jul 2025 23:02:50 -0500, Aaron Kling wrote:
> Add Tegra210B01 support for DFLL clock.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


