Return-Path: <linux-pm+bounces-4907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D5687B66F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 03:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7EF285D1B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 02:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867D3624;
	Thu, 14 Mar 2024 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJnPbYPj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF079BA2B
	for <linux-pm@vger.kernel.org>; Thu, 14 Mar 2024 02:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710383625; cv=none; b=ajtXYAcMCE63kazRR6yGrodOaA22vt6z+YUNGTnQ1lO4ZQ2giJbpk1GcVbJdKg3KaYsQKItcOJF376l9ftSh/IH3H782M6Gc5VRHXB+4Mdf1sYNq+elN/ZvPrIOpTt3umgBjHxF/pVxVSu4NN+szLaEAG/RbHPXm9jWbiMKuLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710383625; c=relaxed/simple;
	bh=I85basKocHxtmG9yL6RryX2s8NhuKTW3wrWm8AKGgWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X00AqBdKCbI3NEN5sDhxwI22mmWLRTA7Ik+gVaUHRx4wNhHHThFFqiTE8JvEB0gGoiZx8rP2EIvcNhUdRjzq+iDkTaJEq+uhWoI10gmVrViXKyOSxsN1Bkd/ArDzHTyNbdxOt4EMBuPPz7uflCki4m83fo7DGncE+F+Hvam2gxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJnPbYPj; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7810827e54eso32314185a.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Mar 2024 19:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710383623; x=1710988423; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xoj69Yx+LxyQfWv6fPLfRPj402VNQZ5yfFTmcJP99A=;
        b=EJnPbYPjCOFChqk5tRAJeOQh0LAdIcKEhWTFvbnCjRwuLtZRHBWO/JX2QFJqK9ItIy
         Dtx+RwavXlvZCbmXXR1qRzGMF5q1OwFKx94tlm94yDw+boSztqKddSAHowZf0yXAz0SM
         Q228TRTuS4FiZULwRne5X7DCx0Qeu3671uy40lMultqCfMTvYzEO1gLqDF1b8WBYJUmr
         tNyyODSVKR+zQhE1Ik9DKJs0lH/YXQGT7l4T8yI8H40Sz1edy1akL+fqXRY1OCrccOpi
         Rsl7nXGm1I34oOURhoT74Xi4z3abT1FD0+Q//peqHIkp/uOfzJUpmMFKN5NufzAMuUud
         Ft5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710383623; x=1710988423;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xoj69Yx+LxyQfWv6fPLfRPj402VNQZ5yfFTmcJP99A=;
        b=ruW7iK0TYkPTtcLuNXculDYrbpQIlaDXrTEmQlSrcyvBmycqUBxQ98Bk2oMrR7O60f
         Rk7ZkoUtf3D2GGsbGmFnSqqhQUbBA7rE/egZe6yjk48Zr+lcvl03YiBwtMZVrUzTonTg
         td2xRw4y2w4wFyuncNp2/oZgo67GlsZ+UfgqV67qMSvYxR9BUQnOJMEFhdQa2cyVimB7
         wh3mvulggiY8buCoZuSB8KzHk+L1s5I8Or+vmpiX+cj6NIeOEJ8jQ+zsW/pEHKKfb00/
         /YHPpmJ0qZjx0ledHjwHzRd3NnSDyuOeFDc0mVBgADSmR/iXMvzfXcxUXmbgfbPPkpCQ
         oMgg==
X-Gm-Message-State: AOJu0YwF98/7S5LRLkTa9g51q/CyKCg+HykWJtfbp4oTEpnNH0asNtj5
	ZWr4ywDkCK9qWXwZy7Rb3mQQX7iCMK8wGUWI6is9yuPKsNGNcEg6sBiM6sxpe4MslA==
X-Google-Smtp-Source: AGHT+IEj1ulfZez/pYshIHIBprIdEvSw/QVeiNHp+B2SKX+wAutOjih5H82Qv6kYjSS/6Qr8/4ykPA==
X-Received: by 2002:a05:620a:15ae:b0:789:20be:ed60 with SMTP id f14-20020a05620a15ae00b0078920beed60mr584172qkk.70.1710383622692;
        Wed, 13 Mar 2024 19:33:42 -0700 (PDT)
Received: from zijie-lab ([2620:0:e00:550a:e7a1:321b:1b99:1b12])
        by smtp.gmail.com with ESMTPSA id h27-20020a05620a21db00b007885e5a81cbsm237784qka.79.2024.03.13.19.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 19:33:42 -0700 (PDT)
Date: Wed, 13 Mar 2024 21:33:40 -0500
From: Zijie Zhao <zzjas98@gmail.com>
To: daniel.lezcano@kernel.org, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, chenyuan0y@gmail.com
Subject: [drivers/powercap] Possible memleak in __dtpm_cpu_setup
Message-ID: <ZfJiBHqQWSKr0EeG@zijie-lab>
Reply-To: zzjas98@gmail.com
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear DTPM Developers,

We are curious whether the function `__dtpm_cpu_setup` might have a memory leak.

The function is https://elixir.bootlin.com/linux/v6.8/source/drivers/powercap/dtpm_cpu.c#L179
and the relevant code is
```
static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
{
	...
	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
	...
	if (ret)
		goto out_dtpm_unregister;

	cpufreq_cpu_put(policy);
	return 0;

out_dtpm_unregister:
	dtpm_unregister(&dtpm_cpu->dtpm);
	dtpm_cpu = NULL;

out_kfree_dtpm_cpu:
	for_each_cpu(cpu, policy->related_cpus)
		per_cpu(dtpm_per_cpu, cpu) = NULL;
	kfree(dtpm_cpu);

release_policy:
	cpufreq_cpu_put(policy);
	return ret;
}
```

Here if the `out_dtpm_unregister` label is entered, the `dtpm_cpu` will be assigned with `NULL` and then `kfree(dtpm_cpu)` will not free the allocated memory.

Please kindly correct us if we missed any key information. Looking forward to your response!

Best,
Zijie

