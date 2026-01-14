Return-Path: <linux-pm+bounces-40782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7D2D1CD7D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 08:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94F223002695
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B1D362142;
	Wed, 14 Jan 2026 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjNmuv+T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58B36212E;
	Wed, 14 Jan 2026 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375885; cv=none; b=XVD4hm214nz0OxGjmPMw232g/sJOC48LP7W4lx5zS3pQil+qAmTag43UlP5/Ly4qi7Aw/J0be6efzKb2QAKaXLMMJZnxYM8FfmHS4H+kfT+ovJ1vlrMETlO2ny222fjMjcP69m+sMs5m38cIh2gt4zsSCFK8eXE9xaM9sVc/zrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375885; c=relaxed/simple;
	bh=odEIaSU88hV8Te2yC2nIi5Pxl42o7d50i9Pl3bAuJ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jre8vHT652REfuGY9hxhLkK18C9il8yLhzEgFRzmR1NEX3TJ/9+1wdzAT2Iq+eV+ZEaz5YURZrKz2LTGz9IgeEd9UbaXFN+aZRJmt0pU18zI5/QXGvUvuItLc85pGD4WZcZo6YIoVTgxZGaZB45rMNJFf2npJVVORwZerx60x9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjNmuv+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E3DC4CEF7;
	Wed, 14 Jan 2026 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768375884;
	bh=odEIaSU88hV8Te2yC2nIi5Pxl42o7d50i9Pl3bAuJ2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjNmuv+TVPDmM/A8ySeohL6aoZ9Tbzn33Mf2ndYt2wwM945gD8cfdl43Fr2EvEQnd
	 0G4uLhmx9egVS6ngPGgOoTOHLMzjYeObsppXjCBGRmkhoonPL61SBO3Xbiul/08tNF
	 /njuatBMKLH9tL9aXh4k1VhNFORKzflKguJJ27MGxd4WVU9x/X5LLpLiiAhiqkXWAn
	 6v6ryYpiU+DiAqmNI7WQa4UbysTxbsGDQSsm3JI5tqi2RdynuTSLVcgh6zNZLo5JRT
	 Z8CfrbMfGWx02sEbGWzoJ7Atn34d2HkXQC6bjF5UfkitIq8GkNQRCOsmfP17kEVrev
	 LlMOUDr7zeVIw==
Date: Wed, 14 Jan 2026 08:31:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 3/6] dt-bindings: input:
 google,goldfish-events-keypad: Convert to DT schema
Message-ID: <20260114-papaya-sturgeon-of-felicity-7bdaac@quoll>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
 <20260113092602.3197681-4-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113092602.3197681-4-visitorckw@gmail.com>

On Tue, Jan 13, 2026 at 09:25:59AM +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish Events Keypad binding to DT schema format.
> Move the file to the input directory to match the subsystem.
> Update the example node name to 'keypad' to comply with generic node
> naming standards.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


