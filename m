Return-Path: <linux-pm+bounces-26545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D04AA6ACA
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 08:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A39B3B63D0
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 06:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEEE26560B;
	Fri,  2 May 2025 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+XDzTQh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417F9264FB4;
	Fri,  2 May 2025 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746167808; cv=none; b=XJeGVMoEMc5Xr1RZ46lvpDAyy+mA95+r8mm2kl6JNeGhBuQOmgNLU2LMdZodzKH4PJRS/T6iu4DFrU+j05bRTCV7fxeNiION+fKs9+aa3RNRUXwPrjFeFYbP2iUIYjCrwbBwQi5DS6cciKiEc5bjEWOIp2PaGQXcpWWy2Zbn6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746167808; c=relaxed/simple;
	bh=7PLCnS1LbO0nsTatIKrBoKTmt2MAEzPUeOg81DEl/B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJhXTX0g4m3g+OPXJRX9J8/tznUf+gIvVr8UYe2dQWzwAMg3OMv4p7w2OjVTpO17uimz5VnperSscdKbup8xMZsoS6mBcYzXfpzQfwH3GUlqU0SqkOXdgQnO+JYYXiL2jolQp9LbC4JDCxa33GvJ1WzstB3d7dx2fHLVHok8h5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+XDzTQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F3AC4CEE4;
	Fri,  2 May 2025 06:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746167807;
	bh=7PLCnS1LbO0nsTatIKrBoKTmt2MAEzPUeOg81DEl/B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+XDzTQhRjVkRqFtK+q1FnAQUkt/z+Gh8gzlnseqEj/sGCMorLb6O5i4sqy+oLQkt
	 zou/9/l6bHfhFcz+VZbawo9WmwSgY2fs16JMgh4szHlwNVtUtmbO8UnD9Krs8Mnciz
	 JR86sImHRp8BwehBtPLCvhcuigrXASDBkypjTgI/bwm5/D5hfKphLrJcnP3zV2+2vL
	 xXvDXsNvU5KyUNhfnGti8LAqxsnEZ6qggzGbJQGlODFdbdQbU2HMJX4Q5GIC6OFHUS
	 dk97TDvh8/rY/1qd9YQkNGqxSE6ypCViqrsQYHabAbxDF4t6dYhudPnxcF3DpzWsme
	 QNXOj2YitSksw==
Date: Fri, 2 May 2025 08:36:45 +0200
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
Subject: Re: [PATCH v3 2/9] dt-bindings: serial: describe SA8255p
Message-ID: <20250502-gorgeous-fuzzy-poodle-c10e80@kuoka>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-3-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250502031018.1292-3-quic_ptalari@quicinc.com>

On Fri, May 02, 2025 at 08:40:11AM GMT, Praveen Talari wrote:
> From: Nikunj Kela <quic_nkela@quicinc.com>
> 
> SA8255p platform abstracts resources such as clocks, interconnect and
> GPIO pins configuration in Firmware. SCMI power and perf protocols are
> used to send request for resource configurations.
> 
> Add DT bindings for the QUP GENI UART controller on sa8255p platform.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> 
> v2 -> v3
> - dropped description for interrupt-names
> - rebased reg property order in required option
> 
> v1 -> v2
> - reorder sequence of tags in commit text
> - moved reg property after compatible field
> - added interrupt-names property

That's not part of the commit. Look at other people's work for example
how to send patches.


Best regards,
Krzysztof


