Return-Path: <linux-pm+bounces-26546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B833AA6ACF
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 08:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53731BA47B6
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 06:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1BB265622;
	Fri,  2 May 2025 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwKFv1TH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7D264FB4;
	Fri,  2 May 2025 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746167882; cv=none; b=tuxr57MQiQL8w5qY/N6zfwJMhjB/jYbTjzNRuWjeGbbpeBNG8B3aOX+IB9mqr4GKGm1ztwmbFXakrGHeKvJV9Q3OGIG+Ae4vCSD9SCP8IZjkaHxSsgeEfHKswFq7t6OJGjsgy6r3a3w+5XRjktg3gns6U5RslO/n2+fUzVU/Mmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746167882; c=relaxed/simple;
	bh=IMqFIlZ6SAyyAE5sTtWzqeu643LBdgSXKpb5tiqgPak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZOaMk+RIO48cKXHb2yqKffpWPMgxFDyzOlPYhxUWGpjgqwT19Lj5S2+3PhgEKO+ErOTC6pLKKCTPOzcVMKoXNqBFXcTHzv3Jk9IQ3B6agHGd6DEfGqfmubf4/WuWUyPTFsTEAwDcZQSTGdAyc4dylCnemUvBk/Sn3FMV9pXGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwKFv1TH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D9EC4CEE4;
	Fri,  2 May 2025 06:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746167881;
	bh=IMqFIlZ6SAyyAE5sTtWzqeu643LBdgSXKpb5tiqgPak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwKFv1THI/nBuyaWPwpPU4y6LJq+343nZrfIc1kJhnn6QLZvxPp0p6uxXkRYcwjG8
	 xPYb8Cbz+nfBKIHzwFnwxHDisW/+xlps540FPV7ioTx+L8CY/Jbgrv4ChR2dx3WNzj
	 KX8+iw1BLHuxyJ26Ul/rXrRdSlMWvF4Zh1w6gWaKJfGNIELUa9FQPhQ7bLhyE/M9S9
	 b8BfVikBG4MwiPImuQQLt8y8uoboygT1tJWsMOGsYQYSGy3/70G0okeDYkbde/Oavk
	 yEHO/Iuf+Fv2S2bwNY1R8GYwi/BTwyDMnw22WsXY1cO9GqcpOrsCz4T7dzumXgyuy3
	 rX3u13yg6U4RA==
Date: Fri, 2 May 2025 08:37:58 +0200
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
Subject: Re: [PATCH v3 3/9] dt-bindings: qcom: geni-se: describe SA8255p
Message-ID: <20250502-quirky-prudent-beaver-dcebd0@kuoka>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-4-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250502031018.1292-4-quic_ptalari@quicinc.com>

On Fri, May 02, 2025 at 08:40:12AM GMT, Praveen Talari wrote:
> From: Nikunj Kela <quic_nkela@quicinc.com>
> 
> SA8255p platform abstracts resources such as clocks, interconnect
> configuration in Firmware.
> 
> Add DT bindings for the QUP Wrapper on sa8255p platform.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> 
> v2 -> v3
> - reordered required option


...


> +additionalProperties: false
> +
> +required:

Which part of "required: block goes after properties and
patternproperties." is unclear?

Look at example schema.

Best regards,
Krzysztof


