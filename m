Return-Path: <linux-pm+bounces-26183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC53CA9C4E6
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 12:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC9C1BC2145
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5820823E25B;
	Fri, 25 Apr 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYnmDWWR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130523D28D;
	Fri, 25 Apr 2025 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575966; cv=none; b=m0YUsFS4o+WywAXs9nXJxEO0pvPRNMiI2I+jvpLa36tMmbWPGOefsOzgodJH0SKKqN90tk0yH/kJzLvSUt4Rj20WkPRnQM13iZ8BUIuOSuKnUq2mPvesAcVgbjOzG1e4U//EXFDSoghvSLfW6n7lUQqkXrTsvG1BQgghTMKwd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575966; c=relaxed/simple;
	bh=w/YbtN447aSdBmfIlYkAFSSQSAj3xU7PmAeeakRoArs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSp14drbP4fo7x7BwzNDWZez68UVcpwJt/ll5BQ3knL/waG4OBRTE0jTgKz1Lu6+YOAR9sWey4QyRRaBoBh+f3a1mSP7jOnauO2OHfcXMEP3K40iAZXdYqxiMPhFLWFEXoO5YFdjWjxbKKHjMHjGHlTGUpKsxN9o08smlDPhB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYnmDWWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3724C4CEE4;
	Fri, 25 Apr 2025 10:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745575965;
	bh=w/YbtN447aSdBmfIlYkAFSSQSAj3xU7PmAeeakRoArs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYnmDWWRLrPoavB8wphVdQEsj7fYyH8NujFRmjLDA0Kyiu06rOKGg5D0UGDdznkhd
	 gaVtlNt0UwB9pd0TbOWN433kG6dBIEl3mEPlL7G9GBocMKEoJzmby1ZwKyjTk6drP9
	 EMyNVYFQ/NGo3rKBbuVHnXOFG/1mXREcczvoBl6Ak18ZdMziZfgsUKeXNEeUHyRDay
	 NlQ6z8lO8XAKwoM/yhHosad3MVreqoWIgMPgN44oTGWMI7+EvGz3d2ap5PIk+IWk0T
	 /EOvR1EO5dhB9jOtUNE3U1AxnCSkxjdWgoD0nRKO1ur5P6qaVbqU0igHIpZGkEujJH
	 jn2DoPP3feELA==
Date: Fri, 25 Apr 2025 12:12:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com, 
	quic_vtanuku@quicinc.com, quic_arandive@quicinc.com, quic_mnaresh@quicinc.com, 
	quic_shazhuss@quicinc.com, Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH v2 2/9] dt-bindings: serial: describe SA8255p
Message-ID: <20250425-graceful-psychedelic-leopard-0da7fe@kuoka>
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
 <20250418151235.27787-3-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418151235.27787-3-quic_ptalari@quicinc.com>

On Fri, Apr 18, 2025 at 08:42:28PM GMT, Praveen Talari wrote:
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: UART core irq
> +      - description: Wakeup irq (RX GPIO)
> +
> +  interrupt-names:
> +    description:
> +      The UART interrupt and optionally the RX in-band wakeup interrupt.

Drop description. It is not even accurate because you do not allow
wakeup to be optional.

> +    items:
> +      - const: uart
> +      - const: wakeup

> +
> +  power-domains:
> +    minItems: 2
> +    maxItems: 2
> +
> +  power-domain-names:
> +    items:
> +      - const: power
> +      - const: perf
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - reg

Keep the same order as in properties. You already got comment about
placement of 'reg'.

Best regards,
Krzysztof


