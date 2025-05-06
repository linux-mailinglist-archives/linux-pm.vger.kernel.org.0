Return-Path: <linux-pm+bounces-26743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEDBAACA87
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 18:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F473BDADA
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7B228135C;
	Tue,  6 May 2025 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/s2Uqgx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D78280008
	for <linux-pm@vger.kernel.org>; Tue,  6 May 2025 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547862; cv=none; b=qTITbN6ragldtcycg4Tku7hT9NJzSbHB2ypvOKHr2uDsGRKkZmYi6JzJJQEKHmUce72Pg0ZW9lNNuas7wslnLpM8tVuOnwPGO5TIaCysDU/8O4CLCyA0bz4t0vfFxPC5sXIQkHpxNNjfsowRsXLHKyQHeBYi7zdwtQxG+8eA97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547862; c=relaxed/simple;
	bh=KuRWlruPmbd3WxzHGHv6kBVrCb8OWCj3oQ+K80TpeQk=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=gHuviwrtHGCrJiC3nrhQDzA1n8b2JC3gguvcrD1DqTB2leca9rZI+H0bzk02WQdAHikbo2Y4sNL9JNbMOs6kk9WpdLxiIocNEhF2MRD38DYNMOmAfG3UE7S06i9YFfTrxo/1ma/mnB7INRrbOpOBdW+Gt88MP8GC3LMeZqP0/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/s2Uqgx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso12288a12.1
        for <linux-pm@vger.kernel.org>; Tue, 06 May 2025 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547859; x=1747152659; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:reply-to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KuRWlruPmbd3WxzHGHv6kBVrCb8OWCj3oQ+K80TpeQk=;
        b=G/s2UqgxavYpvH43BqWHx4japkMqaISWvs8dmUC5bOjYQikRgnUm+DHAKZD9HZ8/i1
         SgQV2qQ/J0IGH4ew3eyjm3dsuQ04KqTtokWI0O+zH+9IKOTrQraEL+Aw17+pZqd97k9N
         4zA0My5fGZhRpa2VbOwc0OuXeybbdunYiHrEiGo1o86MelDCrr6HRadG5NFZru8QGFh1
         HL1OutxHeUSNU9z/BUuHTkVPsONkZZTE8iuuSD9OPrASSaNbO6gwqEf1cQAEMR3ScFOe
         WtgAs+Kct9H3JXuA8mVoKcrrnytt4J8maMUsS+HhQGlBf7aT7bNlmq2EwOW57aODeaju
         VWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547859; x=1747152659;
        h=mime-version:user-agent:content-transfer-encoding:date:to:reply-to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuRWlruPmbd3WxzHGHv6kBVrCb8OWCj3oQ+K80TpeQk=;
        b=Gj3benKCuPv7vAwai1IjJ0l54XT3jbYVD/SPyLDfABla9V/7UTA0oWOsvDTB6M07jo
         KfYs9Y5JbwmRDHiy91Zl4KCMtDwls2luAjKKFUKZd9NgEXmB6QigOjS3wXKURcZ02jNM
         wucIyIXXGyiqlXuyoiq8cjsAOeUOWltP2bhjW837ksnfOCaeKRAbF2OxwIscon98zKd4
         TuBvsTouE409B9TlNkHTK7GRD09i/F4cr1YcPgbL5+/808aVcMB1BIHFAGFwRF88+SPc
         5Pmv3mxNjZhG2qeBcgjcPPnFKSLYJ9pTtltEVr2azjrmsD3ey0NUOsPixw6Q86ZgkX91
         +GtA==
X-Gm-Message-State: AOJu0YyP8UIvZybnSTDYRMUTWH/kfzvk+JxWETAFzS+Z48vbpadvj8yA
	IZ0xDKL4dBF/YCpgFEUFfU3nE3mDJqB4iMCE+p9fwO3Qn4RrbdK667A6RyO+
X-Gm-Gg: ASbGnctwKXtEIngqGdSnMjM8yPb1vF+iCGafUatXVZeWkjl9gfTP/JVaJYrcHjsHYPM
	UIMGmkjx5rm1Xrzpyu7MYGcABqWnxrN9DgC9JcQpjNYBSRlDT/oIKTWHl5clREmzWFNFV4XWea8
	rM1R0uiF/Zc0xPh4/56D4DU21xIRWYcV6GqmeqsFugGQjmBVwP9Bzm8O6dxXYWFiUiv2E4FF2a3
	lTZdA0ftHWacEM0C9yTbopNv06Onpehrq2ilcv/59jP05zSQMIPGRPNc1/36XD+/tZ4T4ntFbC1
	fxXGR4jlYgjDYC3d7ynzeoEm1itTv58okwcvSQEITCzL2RRl/DHM9bvsByufemWnRuC8/g==
X-Google-Smtp-Source: AGHT+IETEWNz4XYITTWiBrq1BqMwtaqgZA0kFSd53iT1oUeJI8DB6oLkubMYavI5OisL4TJPq3fsLQ==
X-Received: by 2002:a17:907:9707:b0:acb:23fc:d766 with SMTP id a640c23a62f3a-ad1e7e17ba6mr28842966b.28.1746547858948;
        Tue, 06 May 2025 09:10:58 -0700 (PDT)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.183])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891ee1f2sm722750166b.75.2025.05.06.09.10.57
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:10:58 -0700 (PDT)
Message-ID: <a20552766f8c193abd00ff4004f28afc66e464d9.camel@gmail.com>
Subject: Sharing a couple of docs related to PM
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: linux-pm@vger.kernel.org
Date: Tue, 06 May 2025 19:10:56 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Linux PM Community,

I've added two new documents to the Pepc project repository:

1. C-State Namespaces: Useful for those working with Intel platforms and C-
states. Link:
https://github.com/intel/pepc/blob/main/docs/misc-cstate-namespaces.md

2. MSR Scope: Relevant for those dealing with PM Model Specific Registers o=
n
Intel platforms. Link:
https://github.com/intel/pepc/blob/main/docs/misc-msr-scope.md

Thanks,
Artem.

