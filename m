Return-Path: <linux-pm+bounces-42858-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKFdKVfBlmmzlwIAu9opvQ
	(envelope-from <linux-pm+bounces-42858-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 08:52:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C315CD36
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 08:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA10E300FB64
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5E5332EC4;
	Thu, 19 Feb 2026 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkRBcnx0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37653346BE;
	Thu, 19 Feb 2026 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487572; cv=none; b=RqeUz+2tiy1jCAoUUiux4pSGqHgXRt95KLTM7xIxqJJdNF+rRzFFyNFMNw6nbC0FoiWOGv+EIj95Qh6qRku7W7hZhKrbQdw/uX9tQXuCSFRmh+Wf+iBA65TQq1pwCbXWoPM3XLKenlLKj7wNDFFvWc4pzyPxEgV7ZY4rPqCI5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487572; c=relaxed/simple;
	bh=/PogN26AwfYWMjk7zsa7L6iRLVZiTnPiDIPpU3K74Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY9iQpGlYNmk6CxMRHH1HG1VWqVwDAWZghsEvqEKrJ88XVtzBbz+eFY8G6h4cGl/Vehtsj5j6zIyCQSFiIpzjRqop0IH7i9Q8GqVIbxuU3B0BVtiUHobBx6oM33O5fofgXcvvAEBsy5FlZs9fLX+c/SFgpZTaqgFz7w5brxzhts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkRBcnx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A9BC4CEF7;
	Thu, 19 Feb 2026 07:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771487571;
	bh=/PogN26AwfYWMjk7zsa7L6iRLVZiTnPiDIPpU3K74Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkRBcnx0+aPXOhKqlJC75EsvZdX+PIzFEVLImJyB8kUEhwhnlHpMn5O5dxG6cO+gV
	 WZDFgEkZJKFx5jqvNHlMvO0cWSKMbB6/nBLBxFMxF8vIdYwslfF8fgTGllY8Tdhzmn
	 iI4UEuKRA3VlCWSUlYJVaS8kc4KIvWa9dHhnlpgyEZVtf8oB2SOsSc5P4Fz9JQkk8h
	 /LTkj1lv09TVad8Mn0iVm1zQfAskh08N2wQtQLf+uvvRGwI2AdSrScw3/nZCrPC0Ur
	 rBPquftty9W02zoawnqKPVWhCpmjV+/smKrCLRFxeYAvRELGI64MRqZ5DdFU+5ljrw
	 9DrNPaWbjgmnw==
Date: Thu, 19 Feb 2026 08:52:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: OSM L3: Document
 sm8550 OSM L3 compatible
Message-ID: <20260219-cordial-robin-of-performance-5fb88c@quoll>
References: <20260218-sm8550-ddr-bw-scaling-v2-0-43a2b6d47e70@gmail.com>
 <20260218-sm8550-ddr-bw-scaling-v2-1-43a2b6d47e70@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260218-sm8550-ddr-bw-scaling-v2-1-43a2b6d47e70@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42858-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 059C315CD36
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:16:18PM -0600, Aaron Kling wrote:
> Document the OSM L3 found in the Qualcomm SM8550 platform.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Your changelog does not mention this patch, so I assume it is just a new
one?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


