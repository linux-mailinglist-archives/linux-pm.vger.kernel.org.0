Return-Path: <linux-pm+bounces-43473-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0fJ6B0hfpmlVOwAAu9opvQ
	(envelope-from <linux-pm+bounces-43473-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 05:10:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 800B11E8A35
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 05:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A61C3014C7B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 04:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E304F3806AC;
	Tue,  3 Mar 2026 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbqGTGDr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3E537DEBD
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772511042; cv=none; b=fHiuVEDbp0Uv8CHtsONRpMuak/j4TIo08me1W1+5p1gcoIFVO162qAZkURCYvtVpW/gBv770ItBMSRaeqcUnk33CuFQoe47UV5QDpxRq9J7IGz2hWRNnCZRP5x1C6xXgBqfL7vEClo4yDfFNz1dPeJUdxB6oJpcNToLnmHsR5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772511042; c=relaxed/simple;
	bh=ycEUqxu2VC/LIBrKv1r/HjXANBQeoGPsrUfYyYj7B8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA9vtnar37alDR0yhHaPp/5NBKJdn/GAbIH9PLnb/G1OD+Mmh6PGs0OQZ00TYMDwXFBZ9PlC17nMJqJSmq2Pc0K8qXevoh9L8y2YYbwDIDkM8Ydtz8YcIxaMXMFXXuCx3S5spLeDuS4DFqV7bn/kGAvi3P6XHPjsqoUB9UMKIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GbqGTGDr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3598cab697eso1038289a91.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 20:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772511040; x=1773115840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wm/wTJAYni/bfoPe16quMxTzhtynqt7x0YSgPTMXEuI=;
        b=GbqGTGDrJdKKyBtONZhgh77o7JV46u/xOx/xknH0DtTzlqdxpa02HewHeF6tkw7dxE
         CgSWUZ8LvDfHY3oyflv4a+XBKHSjJ7pA6HZPZ2hvHTvZQ77o9u6K9vmZ0PZdiGPd3WIP
         WIEfSXgTVznBTdtVp4ydMj2SPFv63fesPQxlBPu4q0ZmWKQ5qz5apB4S4jYjayxbwv3W
         9yQ/TeUp0q+1k6ZBNAc9YMUmVYdAFCImPSgzBAbeRTmW0rJKg1Xf1LFMTbX2OwU2f2wl
         cz4uhWuJ1kkOWd3ZJPsAC3N+iMrPd9lxr/xMziRephxiId4EgZd18XuLBZAoSCOyZ1SL
         j5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772511040; x=1773115840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wm/wTJAYni/bfoPe16quMxTzhtynqt7x0YSgPTMXEuI=;
        b=tduitbnZl71wk0GDTnL6BmyQsHRVHBXd3wVfbzg0wrzOvLOe2K8ZBsSK8JWaDkXzwz
         lINNULjomimVtls3klV91Wm+2a6mSr9vG0CFotpNLSfSEplo4PdKC4vmABgGHog3esuA
         PmnllDSz01Xaj6JgnCaCkQcA4MfyPy9AAFgms/2TQBOOMQZ7oFBhysk4sLcD/X7xLshH
         vAye2b7iXBKA7fALrN4BU/lPMGbS3ic0ehsjjEW3JTnS9PuMcb1ZYTaqbhmLWSTbRhEJ
         nMiQBOAeHVx9LYDzEAP3MiC82Y9JPOtKN9BZ1DS0M9X+WpbOy9Bv1W8/AAKjiBiu1s30
         c51Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIrqW/X6Zsu4nUN5FF0cCAZnsvL41ieDZSd2zn01/clpF4Iv/tPmBrj3O/+5ioGfV9SqBybH0tTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vIraWIQ5JvUeH+H1UFw6TS5Ssx8D3Uy5SJPXR/hb/H65EvSB
	7KXiHK5xMIarkbTVqKhqNZX9otwirAb6lksRtYlH6cpNHt5pHZ5Ag5RXbklVRvkfUpU=
X-Gm-Gg: ATEYQzztYJuHTQuR8CL4vH1Ou/I+197VgT5u+5mKVE4cYpj+2mnO+GNbmcJY+NBIOwA
	Au4vZo3WhN0nj2k7hNebpy/NPSP4jSAF14EW9vtfmC3VoEIU6trjz9EnHB+a2zq5W0p7ZMQ6713
	+2nC5K4hIvxgHiv5ki48L4cjqEJpUt3IdcgXo2eHQO7ufXTOlaBmILygACGXmL05ZAcym8DUX/Y
	kMjf3AR2zGhPRmlI4WkOi/Dfpvb6YVeCzAllXmUPtnfTUyjT2At3dru7bjZkLJj+SgqwR3tiXfP
	kRaj/ZgYIHlgpMHI04DPIeemlHUn6iw69B9HeEw1Ki+ye7CVShbvSGKRaSDCXIfSHiYYcK91woY
	hlLK1MUNelTT0LCxIEhocF/leBDnISIqzTk0x5iNPBzJh1aK1wNuyGCHduHMt4sLyN6mp314ma3
	sjfeXRHcrR+8ff6nu03WtVJcvg
X-Received: by 2002:a17:90b:3fc4:b0:359:901a:4b04 with SMTP id 98e67ed59e1d1-3599cee8ec6mr697357a91.14.1772511039563;
        Mon, 02 Mar 2026 20:10:39 -0800 (PST)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0787sm895192a91.15.2026.03.02.20.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 20:10:38 -0800 (PST)
Date: Tue, 3 Mar 2026 09:40:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-hw: document Eliza cpufreq
 hardware
Message-ID: <3up7phdh5lywcvdmzwe7e2q4sqhpeea3lre5373d2ayanimjk5@5trdeshj6q57>
References: <20260223-eliza-bindings-cpufreq-v1-1-421f8e1e2805@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-eliza-bindings-cpufreq-v1-1-421f8e1e2805@oss.qualcomm.com>
X-Rspamd-Queue-Id: 800B11E8A35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43473-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linaro.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 23-02-26, 10:50, Abel Vesa wrote:
> Document the cpufreq hardware on the Eliza SoC.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 22eeaef14f55..98eb36bff172 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -35,6 +35,7 @@ properties:
>        - description: v2 of CPUFREQ HW (EPSS)
>          items:
>            - enum:
> +              - qcom,eliza-cpufreq-epss
>                - qcom,milos-cpufreq-epss
>                - qcom,qcs8300-cpufreq-epss
>                - qcom,qdu1000-cpufreq-epss

Applied. Thanks.

-- 
viresh

