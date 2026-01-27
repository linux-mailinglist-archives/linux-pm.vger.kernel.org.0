Return-Path: <linux-pm+bounces-41512-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ3BNEhOeGk4pQEAu9opvQ
	(envelope-from <linux-pm+bounces-41512-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 06:34:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F4901ED
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 06:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72EE1301BEFB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 05:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB2283FEA;
	Tue, 27 Jan 2026 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awnsufdQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C51EBFE0
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769492035; cv=none; b=TSWWNMLtDWT1svpHbvhHWspd6XCnYHya5yewtGTcSSeNJRkhvBmZVdXUjTRWZJuEOpzOD4TCJZDXE7/2vF6ydbZGNY6mUO0iE0nSJSY4C2gTkCQ6piIJ5mt3H6oghidg+7n3qjxkZggzR8Fb0KLdFvIEG2GnLGb8DcGTo/5LZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769492035; c=relaxed/simple;
	bh=VPVt90l0n1FDc6y/5iqeP1EG1k+bkfiVr1UwMQflg9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlHW1yzA/jF4g7cN7Tl7Zwn+WZCimHdDWU8NliLuaK3fUW1FQRSS+9shJdv1XxZ8cCih1ZgG5Juc2vFXqc8W/NPRYhIOYDg9LA6RCUDVG/OJjkyO/bgW0wGuqL/1On6CRVxpuAXzRn3+hBqyCBXp+CDdiDdWcBz0K4q+4ePKWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awnsufdQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81f5381d168so4900611b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 21:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769492033; x=1770096833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhM5WGRNd2lTAZhVGtf3iDQf10cuSEQ42awpHwqmnIc=;
        b=awnsufdQ41NIloq5AxQOOQkxsEEdF5c0Zc3f4kj9NYVxr1pEslDM9h/kA9/olxiE3J
         RnqC2TbGsfL4ezLS1X5Zkh/2IyKP0FuibVpQvPOlltoPmgS0jRjJ+qBfrWV8NKy8zQb9
         cH1py0If2odcagZde5Lq27JKSfSaUC54ZP1p4+oiPE1naHGDh4mFf/R97PhAipolsyUy
         hjWcTRUP5pF9HJUELtZC7UXivWA4w+gsXxPylbsYzE5acdoXHBj+NT4IXLy15jlgfmXQ
         MOg6jsjfETx8OvMi0unTxt00yaH7MeEX8wH8LIlmwceR2bLumf0v8FGN7frQBDNXDFpE
         dqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769492033; x=1770096833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhM5WGRNd2lTAZhVGtf3iDQf10cuSEQ42awpHwqmnIc=;
        b=NumWywsyB79QKhHEGVOQvcZucVzHIGlQtwlpuu32t+6K9B9xwFPVsdbdOvkDimtodD
         qEYYAAtcs8zpAQQz1f3ML1uYXSK+CvvOCBmMhg5OY8F4gEyOL7uKCLl3YieFdt8Oz8xM
         JsiDxG95PdAAaqdrv4gx+1mTT1D1shLQBrzMTZ1NLtYld0Fa5oY/Ln3x5wQw8Gj7WTtN
         3gTR7W2BmuggHlKypjCo1unuF+IA+uVgza7g7kM2sb6DvPJUrJbHJQ7WBsYp/NmIecWT
         XeXr7Vb+nu4YVG6qq/Ozcq7FoQDpRziLtY8MV+TIdkq3eWsT1jymGvQufoRUcoM20xSc
         Pmvw==
X-Forwarded-Encrypted: i=1; AJvYcCVe3l6wwYWiNfMaCZ+h5sFrGgVqgH5SsPwFYljhoPUERnDoPRHmRADTm434ZxztEmkCPtsT6o9t1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwg2G/09XJGjwzfn6IJcY063afCZ+o790h9VNKM2/e6F8jII61
	bj08XG2kXgGpmI1XTy1HyNqaD6OjqAGWnw1IIzBJ0TMKlXTzDk3Fq3OIcLpVSkPTJWo=
X-Gm-Gg: AZuq6aJchIQe+nUjAifjdOWgMIuEpdssK/XldKCu9VuamrVT1Uo4M1/RVXA4nkPP5FS
	mB9/aSG/LZ3XnTUvLnoNRzawczxnkP8eIr/7rcOGsUtCr7DRzK0ivRuUM+S2crSJrRb1nQcClZZ
	DU4p41Eut2Lw2AVIUYZkmaq6SGqaRJ+bdK/+uT4juaPf+3QDNwWL3xuprIzXYA6jTPoNzpZOSwn
	2KvzffrqPr3CkLcRblmRjrg5VOpqB9/rtW0SISlS8DsamHSF9zPZllZm4xaaYfsqaReiY373UEs
	THaRyFzLri1Ab4KmN/NDoR+bpY/SWFuYMcsjVOyiCp6A5fKiM3hjCdtQaARyojowbi1Z0uDwpyZ
	SAF+TEznDGd8krKXhRDdYp9c1DKefEeFpEbFYsc8TlKfdq62907yzkWu3+uV7B2dgQHsnGGaVhJ
	2YDvXa8HTaJOg=
X-Received: by 2002:a05:6a20:bea6:b0:358:dc7d:a2be with SMTP id adf61e73a8af0-38ec62d5ec2mr468783637.17.1769492033265;
        Mon, 26 Jan 2026 21:33:53 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6128145sm1173492a91.8.2026.01.26.21.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 21:33:52 -0800 (PST)
Date: Tue, 27 Jan 2026 11:03:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aleks Todorov <aleksbgbg@google.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] OPP: Return correct value in dev_pm_opp_get_level
Message-ID: <a3comdacnan2ztxsxfkjqh6wp732ytsrixmqvm4pb7xlfvuiho@2fycbsezj5xw>
References: <20260123140344.449458-1-aleksbgbg@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123140344.449458-1-aleksbgbg@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41512-lists,linux-pm=lfdr.de];
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
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: 508F4901ED
X-Rspamd-Action: no action

On 23-01-26, 14:03, Aleks Todorov wrote:
> Commit 073d3d2ca7d4 ("OPP: Level zero is valid") modified the
> documentation for this function to indicate that errors should return a
> non-zero value to avoid colliding with the OPP level zero, however
> forgot to actually update the return.
> 
> No in-tree kernel code depends on the error value being 0.
> 
> Fixes: 073d3d2ca7d4 ("OPP: Level zero is valid")
> Signed-off-by: Aleks Todorov <aleksbgbg@google.com>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index dbebb8c829bc..ae43c656f108 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -241,7 +241,7 @@ unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
>  {
>  	if (IS_ERR_OR_NULL(opp) || !opp->available) {
>  		pr_err("%s: Invalid parameters\n", __func__);
> -		return 0;
> +		return U32_MAX;
>  	}
>  
>  	return opp->level;

Applied. Thanks.

-- 
viresh

