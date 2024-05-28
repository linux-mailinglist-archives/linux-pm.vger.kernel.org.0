Return-Path: <linux-pm+bounces-8221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A068D1450
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 08:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1531F22D98
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 06:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912314F207;
	Tue, 28 May 2024 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WP67QiS9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D0C73444;
	Tue, 28 May 2024 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877266; cv=none; b=pmjmNB99sFWOhw9s71mLuoRzqdkTXUgtcoNq2fAYgq2ZnNGZSQTnBK6Z3jKcpNzEZnd+OEd9QojWHJji1EAPrKDIJYvBMzQG1htwNtJ5La5eRc18JGE2HAJty1KOu+8eUxfLrKhb5GOO9hx8i8XCHi3gaTBEqhnFN6WUMTJQyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877266; c=relaxed/simple;
	bh=6Q834IjZIppI+cFVzBMKcUAM64SvnxaeQ4qP3b2MB1E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=AatlAGy8qHjgCNOqBv6ndY1rVMdDe34pxcBpyT3AYCF+PPFQXETWrt+krdR7R/KttMuW9n+fQkEitwQl9phC2mSLteENnLQNVHr1N8SJcCPJ3IyquJ4wIS4yczUIMoTN2cwxLYHHnkNrGwwKWcDuk8psSIBoHemGBaJVjLA5I/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WP67QiS9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716877238; x=1717482038; i=markus.elfring@web.de;
	bh=6Q834IjZIppI+cFVzBMKcUAM64SvnxaeQ4qP3b2MB1E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WP67QiS93W7TAlYhFIzua5DylezAtmnX/et4nqh+fGG5eRbQyvF0D6r282TruLXk
	 1QkMtSbR3jNfljL58vZiEKmF9gaQ7fTwcMwOGQubEZk9V3sNowoXxJPS6mEq/8WvT
	 VevahtwW3VDPqIIpcnmbhfQIAd//u1xNc8PSYHS+bcEKrrY0Nic7z9TanNPzY88jA
	 0eAID1+IfTBSCAdxlIVpL6MtE1ibCchV5ZPoAKn4CKJNfQ+bbQ+CCQr432XF1Kv91
	 BYVmOr2gwuAK9+R8gMexbnjLZFJscDM+UBbwivyxStqdoalchq788Za2IsDy1aYwf
	 MQWM8KywEIg2SFDqlQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDMb-1skLKs3qaN-00bHRo; Tue, 28
 May 2024 08:20:37 +0200
Message-ID: <9842d369-0031-49d8-85da-c60dc39d22c3@web.de>
Date: Tue, 28 May 2024 08:20:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 lkp@intel.com, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <vireshk@kernel.org>
References: <b1378c474427edae9c17a6e84b628c1f1cc59d6c.1716874256.git.viresh.kumar@linaro.org>
Subject: Re: [PATCH] OPP: Fix missing cleanup on error in _opp_attach_genpd()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b1378c474427edae9c17a6e84b628c1f1cc59d6c.1716874256.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZlcxiBe9Ah5GnZ/mE5B7wPE8ueMOvXglSnE0BederuNnKwxq3pW
 N3pu/4NaRff4aQ1Luxa0OYViCNIXA3/Fu5OvMRY/9iKOSMS8KD+pTy2pJF9UkAMRFEu2fjN
 K97jESYJqrJgvBweKqekLfWu2HO+WFWjBDxKs+SJxQ44/mnbxvjX+hRu3LqXRZRgl6zXyAI
 Gf7Ep2FdfneTxlhOc+xFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cZIdLLgOut4=;M7qpztxWtua8BXYvXdbaTD3mRhm
 DqD9Zg/FbjSm2gqyhebJDj0/VvQ5IakW31DqOodeAyt3EarpTx+Y3Sca4sW0Ml2FZfoW+huyf
 DgFS3kWBp9otFCy8bbe4DF9MPNImHALNTObzdggr5ifZJAEGP2srWVrcrxul2EkVhctfgdNFx
 8opy9vr2StPAja8D8k2OYi71+D0ms4VXTihBEsa5/pyP9VxPvPhhtkgJ5NV8LAwRTY14FhZNL
 jWSV+T+Jv+gjc5zL3JKpAsaH/tqD3YsVLnpQEfh7tE9oQD2+uGTk2StJQijA+UpnMZOCSdI/E
 5ru43cvnbapbEbRIp23M1iGQH7EvoNVMJjU2s5eNQ6mWPtwntMgIYMokv6Et6c9pKfLH3pHom
 k3kL4oH3CZIHH4aN3N/22cJEYoqzM2oNeQkkjYp3iXwJU5W73wKje4KSrjxxeU8JIMF8awpZr
 qcZkYS21IaAaq2aU6qd3FObSBy/d4f+Zv4JMaD27CZnjo179tf5Zz5ECiztj0tkB3C07+qBOo
 sJEjM91njOOU8rnB8kAV7CY8cbwbYEYIjMFFzC8CNdmdNsbKI2Vm7b/N3Y7BmGefkXD3GwAhk
 8Alf+xyI1JOfG4BwheCKk4BpHYMktXDtJNGRaMQseWohaCyoTnb6wlKYfvW8IXF6T/O6ie6TT
 MtinEJvDuV6ByzEbo+GQEyUpypdAHYFoI4Q4SeVyg/BawJiU72MEMCPtkOxWOXY8WUMAO9fbY
 ujVytM9mC0MMW4Mq3KHeRwN5g9zRC9HPxIy86qowhjR3aB6V+iWqpz0sE9OqA0ou3A9G4q5Xs
 cceU6Tx3pIwzApnFyW/W+adL7X3ZX67j1m/7Xw0OI0oMU=

> The commit 2a56c462fe5a updated the code mistakenly =E2=80=A6

Is there a need to reconsider data for such a commit reference?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc1#n99

Regards,
Markus

