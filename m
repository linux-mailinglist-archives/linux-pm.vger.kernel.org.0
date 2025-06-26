Return-Path: <linux-pm+bounces-29592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0898DAEA22C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3FC173499
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A902EE99D;
	Thu, 26 Jun 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME0xteVo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9F2EBDEF;
	Thu, 26 Jun 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950046; cv=none; b=allt3I/49GttzuKl218VyqRyD+CVThWTeA8lY9rbRlrd613TggMU/CJ61He7Q6O9kwox+Ck3KjwsYos/dOWMa2aN1N5kRazNUfMg4avGj0slLcujpz9FMMPkXH3mVtBKcN9AQAQ0XHpDXdlsAhKMlsg0rNG3Jf5jXga9f2IebFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950046; c=relaxed/simple;
	bh=/gT8heUBQ3Z05xBH4vV12d5Lb//+FEkn0bNpbdFYKx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSokV8he8hAV+nWkgNZQR/dDchMtrlcVm72EmBslnLr+baQQ1aLhqKSTDWoaUbg0Y0WnLG1TNbe7T+C7c52a2ulLq1xz4XoKdIYcOXsuvRJRk+iLnfk3IeibhHzeVVExgsZ9BKcgxwjaDq5AlTqxRmJ6FnQXJPoM+jXl13SEdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME0xteVo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so6216015e9.2;
        Thu, 26 Jun 2025 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750950042; x=1751554842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBGyUPVtexsma6QWRBZRifNwyFeoUzD3AR8JqwIxFIE=;
        b=ME0xteVokNXKXsHvB9qkgdcgo20nFz081fY8OR5I7eZz+gKbmJmuljQf67w65WWQmK
         fn7/tC75SEFSrUKUmdF8y/yzPCsj2DrdioSVvzP6na1OzM1Iq3JBP27Xkmdupk19LJqT
         NM0b2iuapnUDWhD3ZI3sWS2gXAsBUux6E/WXVjevmYEMjzxxMYmkBmLdCbH6dbdaN3DG
         Dz79A7X7PbJNEcNJSHCcW1CjHamsInV0H6+NvnNSYubxsmVSyzXWXX/frRsJ/QcyTf6h
         18ztZ8BsB5JtBsdNP+z7GsTg4i373CBW5bDbQv9M2eOjtcTvWqbvbAcLhlH6aEjVmj6l
         CHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750950042; x=1751554842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBGyUPVtexsma6QWRBZRifNwyFeoUzD3AR8JqwIxFIE=;
        b=S8XaLTZWq4ocAWt6jeFYbwj/BHlj4QC654+QlJoDVx+mOm2VXwYGRVzJjbfUDKk82V
         767LnJIBm9xgzYZZbC6Gl1huYKZxIfjUTWuu6SEJoxio4QBWiWDZWBwa28RTjACNAVah
         OBbhrL7NE4sHHRKrZggdaYTRSc2mCKlKwNXFz9B6dfEl7rSJCsM6X2VH7J8HoKPQARnj
         W7Xl7uLPQsPmi/BecU3OzMmF2A/qyPfN0mrcE/TGLmGEsciAQOH+hDcQLPkFCzzxMsH9
         H028a4FPYOJ+8qbedZ2SbGpXZjLFrBSKHZZ39h74nQk06gcNzLxF7ZYkyi7S3/fBif5W
         63zw==
X-Forwarded-Encrypted: i=1; AJvYcCU+UXr1oM9b75IGXw70MAK71EMoHqTgkArNYP4uSJqIaHoesW6eiF7stlgPk/W5xf1DEzzr7VNJRB9/6tXw@vger.kernel.org, AJvYcCWRxJ8YuwkFdZKFzLPqAj9kzTqkOCLCaOOxDtPNrxwBq1FVflpu0yV+l4tiSc9QdpD+o7gDzpKY0eCKaj2v@vger.kernel.org, AJvYcCX5fu4G3CSLNvtyJ7cYHJCZdw+lXxWz18gkfnh5mqY6oWjREafuojuD5GsKoTijb8sW7/IFpAF2F4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFistn9qyS6wGQIMT9Z/9ElTERkkXABKO1P03ODMH/soSGsSAJ
	o7epi4MIF0yClG8sH0m5ozXUSJthUSy1ohlhk4sFv9VGXt5SPMl6djWI
X-Gm-Gg: ASbGncs3qk6uUIAQIxAXOFuoQJyoWmhl7GPoDWkhUxnEV3NpHms1dnU/H65B1/gQAqu
	0pdLJPpIqJLxvRLmM3ENVKwAKTltdclpkIf6XfXfth93Pbw1UScmf/u0PF3QGG4pv2rn42sZah5
	2USqxMxdXeXRB3IGXJA3Tb8ddiwsuZYrnsDhAeNyQ+p6ICdvkxFFoZCpG1kWYp3wq1Jzkze9Bhf
	rqTPgCxc4jJBJN+8cCzq1YIkLEjEyzZF5YcZ8bhbbpLD39mwpipjTT2zykSkzmeZJzj+dnqDdgZ
	/VcDstX1/7lfTnLZ0zPgzHUbuQvtOls2PpkAARBkUXsx3lGxh9Nj3VEA1woSNHfnSGSEGTbWWt4
	X9fUs8EiKJr+RnWCveucJqrqvosTEE6goB5CAbA==
X-Google-Smtp-Source: AGHT+IFzXXD0K2hy8zfMgy/bRNcrMH3XjipsA0in5du/DiH+ioT3nihHoLTw08S4Ydosgwh/XQ17Vg==
X-Received: by 2002:a05:600c:8b23:b0:453:8042:ba9a with SMTP id 5b1f17b1804b1-4538eaafe29mr99505e9.28.1750950042008;
        Thu, 26 Jun 2025 08:00:42 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4064b1sm23079715e9.29.2025.06.26.08.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 08:00:41 -0700 (PDT)
Message-ID: <3b90caec-b4c0-47d8-bdd7-1a7abd5e69d9@gmail.com>
Date: Thu, 26 Jun 2025 17:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Content-Language: hu
To: Johan Hovold <johan@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
 <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
 <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
 <84b94649-a248-46b0-a401-772aeb8777a2@gmail.com>
 <aFwBYRF0wJwVDdeX@hovoldconsulting.com>
 <ac5ba192-b538-457e-acc4-c2d358b1fd0e@gmail.com>
 <aF0TIWfDI4M1azzc@hovoldconsulting.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <aF0TIWfDI4M1azzc@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 06. 26. 11:30 keltezéssel, Johan Hovold írta:

...

>> Nevertheless, I think that we can have a simpler solution. We can create a
>> wrapper around icc_node_add(), and allocate the name from there. I mean
>> something like this:
>>
>> int icc_node_add_dyn(struct icc_node *node, struct icc_provider *provider)
>> {
>> 	if (node->id >= ICC_DYN_ID_START) {
>> 		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
>> 					    node->name, dev_name(provider->dev));
>> 		if (!node->name)
>> 			return -ENOMEM;
>> 	}
>>
>> 	icc_node_add(node, provider);
>> 	return 0;
>> }
>>
>> Then we can change the qcom_icc_rpmh_probe() and qcom_osm_l3_probe() to use the
>> wrapper instead of the plain version. Since the wrapper can return an error
>> code, it can be handled in the callers. And as a bonus, we don't have to touch
>> other users of icc_node_add() at all.
> 
> That would be a smaller change indeed, but I don't think we should
> change the current model of:
> 
> 	node = icc_node_create()
> 	<manual initialisation of the node>
> 	icc_node_add(node)
> 
> So given that we need to add some new helper (or export the internal ID
> define), I think we might as well add that icc_node_set_name() helper I
> suggested might be the long term solution here directly.

Ok, I see the reason behind that.

> 
> I also don't like hiding device managed allocations (those should be done
> explicitly with devm_ prefix helpers so that the callers can reason
> about ordering) so I dropped that as well.
> 
> So something like the below. 

It seems to be a cleaner solution indeed.

> Note that this could be extended with a
> name-allocated flag and an appropriate warning somewhere later if anyone
> is worried about drivers failing to use the helper.
> 
> Note that we can't use kfree_const() unconditionally as I initially
> intended as apparently some interconnect providers already allocate
> names for non-dynamic nodes.

Not that I want to worry about anything, but for the sake of completeness I have
to note something. Theoretically, freeing the name in icc_node_destroy() could
cause the following on IPQ9574 under some circumstances:

  [    4.003692] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffffff80047e4180 pfn:0x447e4
  [    4.008439] flags: 0x0(zone=0)
  [    4.017545] raw: 0000000000000000 fffffffec0000448 ffffff803fdbb518 0000000000000000
  [    4.020480] raw: ffffff80047e4180 0000000000150000 00000000ffffffff 0000000000000000
  [    4.028413] page dumped because: Not a kmalloc allocation

It is not a problem of your patch though. The root cause of this is the same
as why I saw the lockdep warning on the platform originally. The reason is
that the static node ids used by the 'nsscc-ipq9574' driver are within the
range of dynamic ids. Nevertheless, I have sent a patch [1] to fix that
already.

Despite the note above, your proposal looks good to me. Would you like to
send it as a formal patch, or shall I do it?

[1] https://lore.kernel.org/r/20250625-icc-dyn-id-fix-v1-1-127cb5498449@gmail.com

Regards,
Gabor


