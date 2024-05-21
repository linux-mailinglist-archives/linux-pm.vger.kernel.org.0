Return-Path: <linux-pm+bounces-8016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070F8CA927
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 09:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6177B1C20DE7
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 07:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC5C51034;
	Tue, 21 May 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G76J0h5B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FF54277
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277301; cv=none; b=Buj+VKGdxRinDeoYTdbcZ6aPv7Ir6z3UjjsJ8VIVyIe7j5vkB09tdvcNd/kljadft5CX4eBCDEZLwge2FfaxSo5Bzl58n/1gr2ZTzNjA4GnbSRODUHpIKvILkAYmtWCEb06Vo+QnreIC0sBIb8vwQ8WCPJy4bE9bTfLkr5ZRBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277301; c=relaxed/simple;
	bh=mjtELKkUwfrpNggY/xDLDUgrykHboLmzHpj/LSUmYww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKwWrSmKAooLCvtveaJQtKokT5Roh8gmNZU0eIXh2fUmCnYaBeYSkpunyFuxRyNp/Di9qMmZuR1EEhf1ffX0h9CjmgIccImCmWAw36zCVyPK/pPvNt/16tVHhFI+SibQM8t0Vg470xJUv5DxdSOIeHPe5ETmF3degiSrHjNl/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G76J0h5B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f304533064so10798315ad.0
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716277300; x=1716882100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTurDbUPbvkS6PUjuhL+IuKT0RxpYi0vhPM0kCjr1C0=;
        b=G76J0h5BGRX9xvU3gGzDJtFCSoXpLf5MgNTMrQ+9y2T5CQiWAmAJnvRA99FoUsCV76
         hH+Fpz110gU9ns7DT9De/f6ga1ZB4ERuZcb201e+NxQH75x8/S41P+uIFAKK+su1mSZ5
         R8P9F5uRpuD65fyJJaej1qN3I4qfBpz63JcUt0DJPpUqwGgHNwlNpIH1vcB4JOMwwXZB
         uh4f2V+LF7F8D2HZQKXwohuliRAL6XFWJlZptsZmTIeJDjJR4pnpo/GAFcQL+qa+F7VN
         yKO2O+zd+Wz03SwAWE2VNM76lmiJVrQ9E4cBK/mgI4PnrsmZSG5Xh28B9rwn2ec12RiO
         E8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716277300; x=1716882100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTurDbUPbvkS6PUjuhL+IuKT0RxpYi0vhPM0kCjr1C0=;
        b=omYHi/XhHh00zLW2aibunBepZBqmCUJH/GogaTiNbKjYBd2Gm1DptnfCwp936W3m2T
         jBI6BhsiPwnrTmjaxhuT7wuqN7Jbu5+rVTTfF4tyPi4YqRiEg8IZle3Ot9eC8eQC9ud3
         t0hsmHhQf+TIfBJsUMGbpMG1CRrySmsvqX/d6KXKyI9u7Wyd4Bij8g2oVnjAZwWz3vj7
         FM5soYWY0G6/S5lR6gV86GpeVFywMZjPC3NEzs90pI52+WqB7MgvCXuBMkyvXvpcTQ9y
         ddwku2uhmj8Eajeecz/XLNicI4QueMHJaCb2XIZafEPyovEBYcgpfHXth967bpDgQ2AS
         QhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQh7GKSQUFwlBxc3aFS0ql9sX1RD14D7RZwsT/9dceByeePGLUStekUAGGQ70G3KU0BIL3bJIQ2C53DT4FKjQ4Z4wsKp3HOvU=
X-Gm-Message-State: AOJu0Yw3J3/upK8rEvtiG2bHFf95EDkC3T8CWSbzL9po9KVFNEt0Zmrn
	22CM34t2oW7e7w/lrjANfMh4F/z8ERmWEAPQIDHmxBDq5xSc9piDZA3NaBGi4BM=
X-Google-Smtp-Source: AGHT+IF44Xi0aDyYujmDzZKwTTyNDVJcAd8OezFjpsoezFltxjzyFbaz9O76NbyQkXwu4OlPguIFRQ==
X-Received: by 2002:a17:902:ce8e:b0:1f3:81c:c17 with SMTP id d9443c01a7336-1f3081c5fc2mr48526185ad.23.1716277299740;
        Tue, 21 May 2024 00:41:39 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137fc2sm215397955ad.258.2024.05.21.00.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 00:41:39 -0700 (PDT)
Date: Tue, 21 May 2024 13:11:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: David Dai <davidai@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Saravana Kannan <saravanak@google.com>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Improve VM CPUfreq and task placement behavior
Message-ID: <20240521074137.eip3jcnu6yhryrgq@vireshk-i7>
References: <20240521043102.2786284-1-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521043102.2786284-1-davidai@google.com>

On 20-05-24, 21:30, David Dai wrote:
> v5 -> v6:
> -Updated driver to use .target instead of .target_index

May have missed the discussion, but why is this done ?

-- 
viresh

