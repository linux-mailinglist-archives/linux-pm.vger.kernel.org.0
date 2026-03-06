Return-Path: <linux-pm+bounces-43726-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM9NLaMmqmkPMAEAu9opvQ
	(envelope-from <linux-pm+bounces-43726-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 01:58:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649321A121
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 01:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 600423012CD7
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 00:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A88E2F12CF;
	Fri,  6 Mar 2026 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoOHHlN2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077718460;
	Fri,  6 Mar 2026 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758689; cv=none; b=TPfwrOVAoKk5BCGAm4LwNKJhBNS9kuidUaPCcAfF0qzPLyxI0Sk+0zBEOhF8o4hSBtqPPVFEIfdbwNON2lkQ+vPCurZ3+Kpsh+HW+iWRsvM2mul4IFepnCUMvppYOBtmrgoxmc+0AEaSUpOace7XK5bP0COhAfdpOYvs/26gYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758689; c=relaxed/simple;
	bh=5e5Gf2h2zDHX7apPUfsiiaIYOEsHOzeJp7URjsOvOeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZSz/KsaNA1iOVn5X6gX8ywSkLcZcwWOUoXkCcVnvCeXU8OI0MnGt3iVlYRWtYZ1PWwuKLWWTKPMGQe4jWbB0uNQJ9B0gHnj2XQKgt8LZvtQiyyTnftoMmD2hmFUZwnKV6vHyRQLFKuqRlEGGjJKyA1nfnqnlaTCdiWiNXKYkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoOHHlN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA50C116C6;
	Fri,  6 Mar 2026 00:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772758688;
	bh=5e5Gf2h2zDHX7apPUfsiiaIYOEsHOzeJp7URjsOvOeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoOHHlN2mmz7PSHA3p3oT4sfYJRXhl6mYzO85N5WRXjS4mwci81iI7CezfIdqJybH
	 oajV1VIWMEvPk3k9SeJvJrhLCZptoaE5Zxe2/vpH4YGY6iJm8BDCljtGKd4Bur4+qk
	 F3FvKSvA1kVLle6rvIo15DFhtSNiI0vHN2uQlpRk4PmRYN55qIALKD/brslMcdOEwS
	 cVUOoYa/c/8hoxPScmhyBvmcQ4+8hUL2WzQ9lmmnO2YFLAHg1fi1uLLU808n/pMu/o
	 PUCfgdu/Vt0BmICoDowB5bFoNO2ytUEY6Yb83YhmbMNm6MpvUlIFqdNm1ewOgliObX
	 dd5N4bVm8K+4w==
Date: Thu, 5 Mar 2026 18:58:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: Amit Sunil Dhamne <amitsd@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: connector: Add SPR AVS Sink APDO
 definitions
Message-ID: <177275868690.887629.16208159676173007840.robh@kernel.org>
References: <20260226055311.2591357-1-badhri@google.com>
 <20260226055311.2591357-2-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226055311.2591357-2-badhri@google.com>
X-Rspamd-Queue-Id: 6649321A121
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43726-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Thu, 26 Feb 2026 05:53:09 +0000, Badhri Jagan Sridharan wrote:
> USB Power Delivery 3.2 introduces a new power supply type SPR AVS.
> Add macro definitions for the USB Power Delivery (PD)
> Standard Power Range (SPR) Adjustable Voltage Supply (AVS) as a
> Sink Augmented Power Data Object (APDO) in the device tree bindings.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  .../bindings/connector/usb-connector.yaml      |  5 +++--
>  include/dt-bindings/usb/pd.h                   | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


