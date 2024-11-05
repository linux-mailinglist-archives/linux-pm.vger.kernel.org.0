Return-Path: <linux-pm+bounces-17018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C39BC88F
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 10:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611E41F22D02
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5834F1CEAA6;
	Tue,  5 Nov 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EevOSUQ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A01C2450;
	Tue,  5 Nov 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797401; cv=none; b=ZTtq6/H936ZJQ6HjfdZVvjlMLibLUYrNgwYfmhy8Hz4rIWEMt9dE+g1CEnlgK/Z1i3QToy9KkNiZd0uIeYVTLqz3rbFfJlkvJtrqTDiUfwcMgVVljCAt49z153ogo6hJnuCNEfSFiCbUBwbwv7qJDK9afIzVAZiKfFoXihIvyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797401; c=relaxed/simple;
	bh=10tF85e4hSrDufzdwvz4xuLjEREDTvvE5KgF64buQI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0E61lbOxFEdGUHChbvMWhWRTzjsCkdRtd0oIBl+WIZFvFfxwBrk68fBa18XFqr/EiYCi3XKqpTQK9NXQRNraCW3fQpgVZjTctcRhOKIcil8F+dGd1M19rn2Aw8LFy6nIqal2zqS1Ab4TCUBJijes25QAeZil2dxORWfy6HfuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EevOSUQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC27C4CED0;
	Tue,  5 Nov 2024 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730797399;
	bh=10tF85e4hSrDufzdwvz4xuLjEREDTvvE5KgF64buQI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EevOSUQ2bvyFGaWzHiGU+Ll0/AQCVdAjr9CcWfdhlbTW+KhvzE8G1kN4nkDdqVfKd
	 Z8q+HM0M26Zs1s6gcI7Ik8qThwzdFoo7bhrNnwiftt7keN+WFltuGA5wbJvsIbnaLp
	 hrG00ku8OHzrUhpxY8isk85vx7BAoatxgdM9N+Qn9HMPtuwTPuE4LXSmXjjVN6ccR3
	 MI32whVNBbsIe0VekGVzYlkADeZFXBDZnXCCc2cgdqgyR8eEr/iEKDDnDW73GpgSBm
	 4Gh4Gs4ascy1A+/lTcHItJJO0Mv6iwU7t5gaRoz421NXBFNl/LjcCFwrHVmpPsvXEr
	 QCNPZ8dr6Py1A==
Date: Tue, 5 Nov 2024 10:03:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: sc27xx-fg: document
 deprecated bat-detect-gpio
Message-ID: <atetahoyv7iz4hvw2avx6gs6kit6owvmfsniorkmzrqhl2gvgv@iwdz7uzcpxcy>
References: <cover.1730720720.git.stano.jakubek@gmail.com>
 <f334c973dd4e6390a0cd51dbde358277a07604d7.1730720720.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f334c973dd4e6390a0cd51dbde358277a07604d7.1730720720.git.stano.jakubek@gmail.com>

On Mon, Nov 04, 2024 at 02:03:58PM +0100, Stanislav Jakubek wrote:
> While the bindings have always used the correct 'battery-detect-gpios'
> property, the DTS and the Linux driver have been using the incorrect
> 'bat-detect-gpio' property. Document this property and mark it
> as deprecated.

Well, I would just correct bindings instead - much less changes needed.
Document 'bat-detect-gpios' (note the 's') and drop
'battery-detect-gpios'.

Best regards,
Krzysztof


