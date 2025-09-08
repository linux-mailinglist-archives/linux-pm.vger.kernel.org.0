Return-Path: <linux-pm+bounces-34133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C8B48603
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 09:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1746E34275B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB082E7F30;
	Mon,  8 Sep 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjlM0ocH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7E2E7BB3
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317473; cv=none; b=ZpzMCSo3YnHhf/6z7ciQPIjMAF8FWq9xMVoZ3uYk6HGCmTfFeQyLIw5TvUxKV6zOS6ukK27GGCSsPEg7omkUFR4zlFTeaLJl8P1207oTFEdWjX+QqXgK+xiIrflbT6NCqP3NnSLATjqIBRFcea9p1RlGAXpbtWJw2ASOulIK8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317473; c=relaxed/simple;
	bh=kL9UTFTOwTwX7nZq68SlUX6QKXEKpUN3PiqwtgfOUMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKhm9+VX8y1RHH8xZq2PgeTnPaVxYtPR0bGSMnjHFKWPaN3euN3emE6mmd7ohqC0lZV9UxlYtCL5zhC6HtQD+RwpW8R46yVENSlHByTrD9bTe3wR9BW+IZal7ipElGV6GK1EDEP/Ehz4IlGW0S4QD/y4NxiGe0vXwWp6bqGD0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PjlM0ocH; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so2665187a12.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757317471; x=1757922271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=toUuFoyYxtz3IY7Dj5fLibZ/IZI1MSArfETrATESfNs=;
        b=PjlM0ocHddk63KZJkHF2qkBkHMt4paRFXVv2/rJEgyvmroC7mZdi02D+SNhvGKS0GV
         k9qoquLZNvDJYpk7LqjBQv0ZGIbxwQKnLpQlMqv5ML6QFol6I07trUjTBPvFld6SzzJ8
         WlaFxVEAcc1kCtNsCe4i2MBp9qYDMAd9YBZWl5KYVg0bwz7/KXRKR2f9dbBwtgY0Sfv1
         d+J7NHBYkPxm7IJzizpsBDbgH9fus+rO0g8cZd6o/TYXWh56wetblw79z8g+FeHliBMa
         CYz+RHqns7gTs3QnPdOGzcEp6C7reS/eDIOg10huQqpNcierYFsAWAMdMSaEXm1eCxI6
         AdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317471; x=1757922271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toUuFoyYxtz3IY7Dj5fLibZ/IZI1MSArfETrATESfNs=;
        b=nqp39n1q/eC5OF33iztOeg5X5J7MogyJ5VztqV0vi6tSjS267fSCyVwuwy0BTADAom
         QKd4CxVTnxoox6QXoauO28cM0a6EAtY+PTTnSGqeabwe6qsrW1OQ5tveD9gMpkyS8xJt
         q77pSs7QM01Rdaxw8sZ2yOTrJXUDiyShZ6amhuqUUusslHyK5/2+cJUivgyFoRu+jtsI
         VFzztIRA8k0FwbB1LAFcESYXiCu+iIlfOv8pZUFY7peRWRZ4SYDzAEcgDr/UaGL6MJVs
         6i7rUwzqJvYxEc61xDaxRMZpa8lyAjtmM9NEP1MgmMM3Bmv5l+e2QR5EOJlV6josXCxs
         IrJA==
X-Forwarded-Encrypted: i=1; AJvYcCWKGPJorTyJUBwEzbJDsXXcPbd/s9dVjFVhVY7H7h8OXGkFUX55AuSeC3gGJOuTdcySJRv4vyfhYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8LMGve2gHsnsdl5C/u+2C6wy8b6Peolunw5N3JuLOdEowbzE
	nh0YDfWuG/JUAO101odyfDaba5YrfRFpoLTCQ+H4nvvrSddCS+s4UjDNZqWZe1oZsmp0EiIB3E4
	QgpaW
X-Gm-Gg: ASbGncshoar2/N7gwAK8QWMqopbaVb2j32k2JzA0jolaMUiFf8Q/hTtOIpiF7JoVLyo
	GFmVPbe4z3AbY6IMaieco4cLCnHNDIyI38SNm3Py5zGLwQSTswXPfaG+YM5hhdrwJlMt5YVs5NK
	rQrSchmRWNiEtTJms4FfcNkmF/uTXCMtBQOXBB3uKLIRy50g7l4KduZzIRC+9WBbHub7jbmCXCl
	ivMrP7mfIkQQOB54ZdJ5Ua1pFGCoREizehDIBvQPb7NKGDiPcVi9rwnZLzm3hmgQzzMEYfn0vDD
	9GclnrMxKNqgfxLYUy3OEIpTUtgifeqQHKs/hpG6Cze362SPQcDBnBuI1IJgSj1p1aF1UJVCzCW
	A1Je94NVIVDwNocYmQVHPpv1G
X-Google-Smtp-Source: AGHT+IGIUDY6HrGYjiBungp/6EW1xfUx0j7BBxotRNf1vw4rmkBz5kB6JcC1rC02ZIp6g3hIMeuaDA==
X-Received: by 2002:a17:902:ea09:b0:246:7a43:3f84 with SMTP id d9443c01a7336-2516d33d4ebmr104112085ad.5.1757317471368;
        Mon, 08 Sep 2025 00:44:31 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9e39094dsm131335155ad.84.2025.09.08.00.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:44:30 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:14:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250908074428.tphy4u7vjhkehwxk@vireshk-i7>
References: <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
 <20250904053700.abdkh23zwi5x65do@vireshk-i7>
 <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>
 <20250908061333.rwzq5dj4nxlav6x5@vireshk-i7>
 <cbe36377-6f92-4913-8cd7-087e718af368@kylinos.cn>
 <20250908065551.d5jhp5ejix4fzgd2@vireshk-i7>
 <67b55ae1-60b0-4d54-8220-59f7e3ba7c29@kylinos.cn>
 <20250908071920.f6ppfr7shy2cb2wg@vireshk-i7>
 <fecd3bf1-c8a5-4514-b3be-311a09abe5a9@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fecd3bf1-c8a5-4514-b3be-311a09abe5a9@kylinos.cn>

On 08-09-25, 15:36, Zihuan Zhang wrote:
> For instance, we could enforce that a driver cannot implement both
> has_target and has_target_index at the same time.

Can be added.

-- 
viresh

