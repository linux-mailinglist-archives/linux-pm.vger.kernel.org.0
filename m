Return-Path: <linux-pm+bounces-19293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C059F2CF7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 10:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDDC1881DB2
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A65620102A;
	Mon, 16 Dec 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pElc97kd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F347200BB9;
	Mon, 16 Dec 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341292; cv=none; b=DmMDva+Sh/NOOSkfU1BQXqwacZVRzwbOI5WJ7KagCJdX3zPkxlE4wqnXXuk0xtA6WrfU21Qv9BofXVO+CJ/USkFFvgChs0Z5RZsSNIFLSjqMFJuo9131PXbdHhFPey1WIIVZn2Fy4TI31E1U6A6YGqh1Dc+kFUomAguXfi3igVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341292; c=relaxed/simple;
	bh=zplvDS/JfEKmgoJ/gVJLJ7g8FjSFAlfcgjYGedG7zmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhNEpucsTl/igQgSavcokk2TFMuAHZElGL46DthD4zOkK8GnjI6k74DalxDsIndEOOOYDpM22csGLiuaufRDAJzRurn69ihXuBedauVS68KBsjpNpkIPZrODmKCgY6h7tfjxwW9NIn9HtYnN3LdT5i0MaZZ+BGZrsQdbuOnWY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pElc97kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40C0C4CED0;
	Mon, 16 Dec 2024 09:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734341291;
	bh=zplvDS/JfEKmgoJ/gVJLJ7g8FjSFAlfcgjYGedG7zmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pElc97kdQ16eMIdJ0baZfJlFx+orrh97gDCgqBl4L0z4QnDHvBVE7JHL0IOAUT0g9
	 +bGEXcfrbenR6AFVHKWu90CPoavRiA5G1BH6R8QjWUWOVZKZFcD9MD+HzlIRvnQWIb
	 AK4pipDyVacG/UcT3D8QDTP8u9r6BJ0TYMcm3Ad5pDTEqOXlh+Lr8k/Kv3vgozNWiO
	 dWkxH8QCMTZfsSn5D9PNT2IO3QOembvdsREuETSKOsaPBX5QxhSkrEYD7Isu3cBscX
	 yFiP+ZBhPUktKnF87GMho/D6Dw4WuXgR039vaLugO27/n5PF0jt3xJljlhADiOAH9r
	 JHnn29sWfMZUw==
Date: Mon, 16 Dec 2024 10:28:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, heiko@sntech.de, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: arm: rockchip: Add Firefly ITX-3588J
 board
Message-ID: <x7y24y3bkbj5fzx5pdprjr5umg6egxsy2xscfbj3xgzgzubvdk@ppncjiqoekk7>
References: <20241215032507.4739-1-shimrrashai@gmail.com>
 <20241215032507.4739-4-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241215032507.4739-4-shimrrashai@gmail.com>

On Sat, Dec 14, 2024 at 09:24:55PM -0600, Shimrra Shai wrote:
> Updated DT binding documentation per @Heiko St=C3=BCbner's suggestion, to
> reflect the bipartite nature of the board.
>=20
> Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20

Order your patches correctly (bindings are always before users), so you
won't receive feedback of undocumented compatibles. See submitting
patches in bindings directory.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


