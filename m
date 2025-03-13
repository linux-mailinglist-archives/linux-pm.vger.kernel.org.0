Return-Path: <linux-pm+bounces-23966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02E7A5EE70
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 09:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A0D3B8400
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B908A262D11;
	Thu, 13 Mar 2025 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBuDpJHJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FFB2620EA;
	Thu, 13 Mar 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855833; cv=none; b=LSs07xNq/nB+Yhwzj972z7XdO+c7yF6yleHU8qvxzcltiRs8UZLfYvvGRhYSV8CbfFpQBkXKVcWRYfPVrYIiBfikhNe8y/enSYjER6uFyP/NsGa39s4oL1aQvsxqO45L2fLNow3KcdBRXZrEV0x3kULf+Yp1koI2QvAg/SU2AKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855833; c=relaxed/simple;
	bh=U27KUPNIj8hMg2Dc6qsyDFvg73E84u4+n2J6eY11nCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEhi0I5dzWRqTxE6mq8mDB/h8hR6OwNrjpbQIk7pFmuuiQcwQkZW2O4hYCTP4+yw9d1Ti5n/hPbL8fBdgwYnNf1KHnNpqr+jljeAb9NAbHlm46TLwgGcboPiyZu7UM+BmKmVaLDsz2SiyqHxfkcKfLTZcpQ0edpMBZcNO7gkGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBuDpJHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AAFC4CEE3;
	Thu, 13 Mar 2025 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741855832;
	bh=U27KUPNIj8hMg2Dc6qsyDFvg73E84u4+n2J6eY11nCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBuDpJHJ0B7/I4PCa6jmfPMjwIkk5SQ6/pj1q6F6bijy66a5SLZJMDQAB/l7qQ8xG
	 72keDsxQ0Qu9Bw5PiY/lK0thp3Rppgv6Am4kHwZRGRUV2gxor4WzrxwdeF6OGgJ7k/
	 57N5KYWdzx7XdA78gYsQ0iJh+SQYpEeXsHRDzbf+q6z+8Sb8PvQcH2S9oTj/YIiqPH
	 w+0SswE39SoI4ggwosDPrv/9bVS5a9AOfgf08zCmpzJOU+d554aoG8IdZql2eoC1k1
	 VWeMuhEYbovx8LS1qblv5fOJbyXaoRum8tOv39SCegy7sx6bSZorKHkdGi5K6pvm9Y
	 8MbSEspDerzoA==
Date: Thu, 13 Mar 2025 09:50:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
	Sebastian Reichel <sre@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-pm@vger.kernel.org, RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH 0/5] Add support for Battery Status & Battery Caps AMS in
 TCPM
Message-ID: <20250313-determined-wild-seahorse-f7871a@krzk-bin>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>

On Wed, Mar 12, 2025 at 04:42:00PM -0700, Amit Sunil Dhamne wrote:
> Support for Battery Status & Battery Caps messages in response to
> Get_Battery_Status & Get_Battery_Cap request is required by USB PD devices
> powered by battery, as per "USB PD R3.1 V1.8 Spec", "6.13 Message
> Applicability" section. This patchset adds support for these AMSes
> to achieve greater compliance with the spec.

Which board uses it? I would be happy to see that connection between
batteries and USB connector on the schematics of some real device. How
does it look like?

Best regards,
Krzysztof


