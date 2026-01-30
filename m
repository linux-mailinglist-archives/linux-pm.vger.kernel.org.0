Return-Path: <linux-pm+bounces-41759-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AmfBBtgfGl0MAIAu9opvQ
	(envelope-from <linux-pm+bounces-41759-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:39:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B49B7F71
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B41F030166C7
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE92E3148A8;
	Fri, 30 Jan 2026 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcKev9e6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B1306496
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758743; cv=none; b=gIwAyftR88FdLH3uVxb8AuJCv3p+S70oJtdxGlw6J0fpHf0bQetERgIwKNYveOafUO8khmFf0CG6feJJBOJkexwPg58fphrbbPKI7Q8T1x858wh+8dWizfTo8cJT++VW4Ks6JFVcxyYtxygNFq2sRPVnkNnBJ2ABsY2+E8g3wD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758743; c=relaxed/simple;
	bh=F8r3x8JJBjSCq+4Tzcnp+PGvvMWz065zCxEkqb2Ys60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ+RDJTQNCAR7lwSj06D9bE7ff/E8SAdPj9oxkJmwyZntCavWh8wdpHCHNiVhkjBwYKHq7YG7o8GlF+S7AFo4n7BOw8ZsbWRjqH2v91SRIcIvhItmEAGru4f60T9cgxMB18BBrmw8HcZapfIpTiSKwVHVED0aEUznJps8yzJ1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GcKev9e6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82311f4070cso1263175b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 23:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769758741; x=1770363541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzaMRjB/f1l9qa954BqKF9x3TOw6hcAs4ipH/mXdRdw=;
        b=GcKev9e6evPrKD6Pq1F9iieyo52CibDHMpgxnX4+rt3azuknVJJ/np46Uf287QBp8L
         JMLZ9S+Qi0FCUWnIJrFPiQjCv/aQG7jVUBX5sjfs+MYKeWXARJA2+AGI7wqXKBoeOqOX
         52Uw3JJXYjt9gJt4IdM+oBypDr+6pRjmymWzifKqILB49M/+dXNNHRwyXpoOJsbTRiAT
         kkCXIPWlYCjF7qIGb4BUykqpWnAXoo14I9CrUKMjF9vMj9iYGf8f/sS1T6NRWhoJOiHt
         7ZldZSMw3Qw8jEDU2U1ezZ2NOLWi8oTrGItKCUubjzf4A4cAbcS30aIu2GugMOSrvHh4
         OWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769758741; x=1770363541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzaMRjB/f1l9qa954BqKF9x3TOw6hcAs4ipH/mXdRdw=;
        b=befOTDA2arPLRbxuOxat+hbUXsB3MRPP5B4RCkGq7PI9Oa7Pt62DH3qkmjvfUOd2aI
         jjRY31ockkcy1Y4zdvi/JZQ93PAtHOsaSpTGmWoZ6dHTfGPoMguGwuzejgCUEq7pUNaz
         QSRjre7PHmXcvbr1OdpwbVGSL5HxDF7ZFdFjZq6YaA0P3Z8jm3oXhH7tVisb2P+xKV9k
         6L4HkHfy+rZRs9tmlyIlTkaO6PmOc9Da2hIa4sTqL47SOHaRj+EWW4GacZc/y43dgJ7R
         ajeGXhLR0U2WpI/A4H2JjcgIhDPiZTLUtY5YBHXZjujTDSB7rtgwx0oXW2M7L4wGi1Ff
         +y7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4fP+imrf0ygvXS6dO8V4KIrwiO0oMtW5P0zUr1ozUomsvSjTBkjUVrgcvNhHyywoPbDRD9irV8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oBydHBE7KWo9Z7sDq4n2g7JAb+dkkMjxRRRyNRAPxsQFAfvv
	T77bxR5eMI5MOZWsD5ZC26Zt2u3ybxC1rs0Y1vTPNg9QL+rYwrrpb7RdCcihoP8G9Lo=
X-Gm-Gg: AZuq6aL500FFqX1zMMjV6JMCdIppB67hufNXxci9rdC8c7e5TeBt1RtHRXzPBMB900E
	jnmr/MfGoF5I2Dbq1yfDJb9lxgyXx+M5Tz4GPRKjAXeGYuPygBm5dxZt3IiCGAqEW2WUTzbuhMK
	YlFErm7UpQi2B6SbsoTLrXn56to4HM4hwhb2ry6UntbzCg+ybbrZSFR5k1HKTzUoxCM8+3jAgyc
	qdp08lhPdIaz05jmCSxzwUtSS4EsReFfShxnJC5daAG7Yu+H7jiqUzbmSoBJi/DR1zqsQ+vhZTt
	k3rh1KH7UlEpBNrVxC93PEHwGnX9q139xxGtn0P70vktG1ksAiOaO6jMQGxpBXGNcfYrWjhyQhU
	5urNAjUNZXysOmKCWllfqY8dis5oYk1muIyRjX5LI+bLXHxx3R2MGY8EjrrmLwNRfQpGuvm9NDB
	GhNzluQXagwtw=
X-Received: by 2002:a05:6a00:a209:b0:81e:4a9e:f809 with SMTP id d2e1a72fcca58-8239201d9d9mr4586535b3a.2.1769758740484;
        Thu, 29 Jan 2026 23:39:00 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b277sm8775975b3a.29.2026.01.29.23.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 23:38:59 -0800 (PST)
Date: Fri, 30 Jan 2026 13:08:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v2] OPP: debugfs: Use performance level if available to
 distinguish between rates
Message-ID: <3u75wj73rmm323wllxlwbmwg5fpq2yx5y7fa3ing5cnaahif73@ognri44kiyk4>
References: <20260130071940.6949-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130071940.6949-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41759-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: 74B49B7F71
X-Rspamd-Action: no action

On 30-01-26, 12:49, Manivannan Sadhasivam wrote:
> Some OPP tables have entries with same rate and different performance
> level. For these entries, using only the rate as the debugfs directory name
> causes below error:
> 
> debugfs: 'opp:5000000' already exists in 'soc@0-1c00000.pci'
> 
> Fix it by appending the performance level to the dir name if available.
> 
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/75lzykd37zdvrks5i2bb4zb2yzjtm25kv3hegmikndkbr772mz@w2ykff3ny45u/
> Fixes: 05db35963eef ("OPP: Add support to find OPP for a set of keys")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Applied. Thanks.

-- 
viresh

