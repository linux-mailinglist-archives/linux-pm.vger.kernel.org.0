Return-Path: <linux-pm+bounces-40783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96829D1CD97
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 08:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 837A13058568
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7793624B5;
	Wed, 14 Jan 2026 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeiWhp5f"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA63624A4;
	Wed, 14 Jan 2026 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375906; cv=none; b=Kcxz7eZdc8v4IOVJn+qMDP/gKXly8bocIMnGkea6EMjsTDRAMiHOslrb6eWtmJHTOZcfumVF9uOqysGVscqksm5TfQ2pC5WLHfGikeh19twyBXxSw3QkSOWhEYIF3xEViPb+/477l46hiFc429ChCvoWNmClhRljDm2g/1XinMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375906; c=relaxed/simple;
	bh=AxjtDJogjMYny70/S8/oxhn7AfCM+IcApWCwD5ErivI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQV6wJp/ZljDewYjF99cN6EDS25/OjehMQUM/8UIKSufu7SU+EpYZiR9sEarN+eeOKMrIuhBxp4fr80WRESEKA2ypVCxqt4eN+uHvNHL7HzAcY6t1tllsGHbypW9ualVC2I/9O2mzej+1Ws0FYQIbtPR1+zc3W4naQUvbvucV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeiWhp5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A3CC4CEF7;
	Wed, 14 Jan 2026 07:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768375904;
	bh=AxjtDJogjMYny70/S8/oxhn7AfCM+IcApWCwD5ErivI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeiWhp5fkC0+BtXDSTUOmHf1fewucLdNdSB5+3y2UtMzLKAH/iJXBEPkO/ISPnYer
	 p5Oe6X3e1gDz0ZkuzUPtCisUecIoLFuYv72qZI0eBjaKFoEDHEXuASHMFPoxJsm05J
	 03uvqRX1gX3zqKM4YKRVsWR6KPD+RyAhtaiAUYmeKda/7NGakzpCWi6L9c6dq4lDl1
	 +faqr/N8Ille+S9R4cblNRJWJTKOb2zJcElVWWej0rrIFODYRLfZUsMpm9EN6uBNZf
	 enzscCRmgeR6Cm0KVtMTiALQVt3pvk7AZMw2155YMoU7qG9tKmH1ANh3Wgl5jrdA7C
	 1tn+tQ6nNjZ5w==
Date: Wed, 14 Jan 2026 08:31:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dt-bindings: power: supply:
 google,goldfish-battery: Convert to DT schema
Message-ID: <20260114-blazing-mantis-of-advance-ddd6fc@quoll>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
 <20260113092602.3197681-5-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113092602.3197681-5-visitorckw@gmail.com>

On Tue, Jan 13, 2026 at 09:26:00AM +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish Battery binding to DT schema format.
> Move the file to the power/supply directory to match the subsystem.
> Update the example node name to 'battery' to comply with generic node
> naming standards.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


