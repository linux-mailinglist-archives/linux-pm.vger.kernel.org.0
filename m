Return-Path: <linux-pm+bounces-40703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE78CD17245
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 09:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80796300B29E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B38318BB3;
	Tue, 13 Jan 2026 08:00:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC162D7DF1;
	Tue, 13 Jan 2026 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291231; cv=none; b=OtbIVp66dp+njzkvg82NNkAIBGTDpn0IqdLW61J7LEgxn7rtUEU3gXjvHqeHA1ZWfBekDn+K7WRV0m8+5z8EbJMPNccx6g0UmU6gcUh9A+Zwpn+MJLYlDqbXQK4IVySi4mhz0Y2DeC9mqad+V5be0FGg6sIXxG1K1zUofAbEI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291231; c=relaxed/simple;
	bh=SX+O0NmEQxOLjAFfursNoYVMHn4XYYdX1/Bzv1rdlFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJUX4aF9+LpSCqk/GAaJmm9FOz2OnmOpbOKwruuwJCev45RCYuZOkxzmEg15VPu2L44kCaUYkS5Zvoa3ZMAzr6REAkUKK+ZvkzdSqd1+nZ+EdJo5/P1iSUpLLea3z1bhbZ40gd7eYD7JS22fsv+wOFTHVDt96XXGaqJ7J1vTQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED6CC19421;
	Tue, 13 Jan 2026 08:00:30 +0000 (UTC)
Date: Tue, 13 Jan 2026 09:00:28 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: misc: google,android-pipe: Convert
 to DT schema
Message-ID: <20260113-orange-cat-of-examination-b8d2a7@quoll>
References: <20260112185044.1865605-1-visitorckw@gmail.com>
 <20260112185044.1865605-3-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260112185044.1865605-3-visitorckw@gmail.com>

On Mon, Jan 12, 2026 at 06:50:40PM +0000, Kuan-Wei Chiu wrote:
> +examples:
> +  - |
> +    pipe@ff018000 {
> +        compatible = "google,android-pipe";
> +        reg = <0xff018000 0x2000>;
> +        interrupts = <0x12>;

Still not improved. I asked twice already. This is a nit, but I do not
understand why I need to ask for it three times.

Best regards,
Krzysztof


