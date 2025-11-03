Return-Path: <linux-pm+bounces-37303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B1DC2CF4F
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 17:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC75188BE3F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF553148C9;
	Mon,  3 Nov 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSYZGuZi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F5304969
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185234; cv=none; b=N9vQvZ1e3iduAlDRVTtA067oOreS8KLZtYjOar3EeZR7P3+Qr2kjhLaNtARF/vx2MzND8XbqYMtH1RV9Po72vzWo1hUuvaPJqWhKUE3BElaZlYlu8EVjy9IhmN493MZZhAQOrbTf83Fjx59pXAUgcP57kVdJ6R6LoBVcV+MH2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185234; c=relaxed/simple;
	bh=qrT9BCtX5Q+ZrBSV86ofie64KLKL7GM3W7AojJFifCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtK8V6AXYQrkMfR+/0ktEQFUsuIkMFdQN4uIsQFFaxuC0aav6prGet85sDmXOm8VIPvKFxYnEsBxjmzDTBTi47m7MuBNT0r3WrE2Q1L9yvQ5MVYH5P9q3rVzyHZaR3x4Tk24HCdAN0jq58iVwwR7Q6tv7ilBDQDr3SVhZV6Vleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSYZGuZi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-474975af41dso34418895e9.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 07:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762185231; x=1762790031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLey69Q1yRBIRmkA9w/tF6nJaEmvXdViphT1MNeupw4=;
        b=HSYZGuZiIcI0W8S8M894OpH3yfk5w71l42+mebiaC3OAjR+bvqAWD9FzbzDwu8IY8q
         5wyxNEEzI89Aqt17V+goy/gOs6aR4adkVDx1XHOZ9rMfU/c7uMdhxjXo0ABXKGSA3cl1
         4fnWSbywWsDd7WwfUI5AQTIJsJus8C7+frvSNkUeMhSDx4TDN/vlcPAdSoW6IWOPOAvq
         tP5i9W4iKxca1M0NddqZM4uNIhdM+51ZMTAm1hSOk/7ACW1+XOi2pNA2UIutcb2hqeF9
         /r+JOBgkOtBHcOBtNEOzk0yNer5Uz91237F30lKwsZHRFnbr8foaeDwsT4hQzPxDOOmB
         wreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185231; x=1762790031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLey69Q1yRBIRmkA9w/tF6nJaEmvXdViphT1MNeupw4=;
        b=m8QLhAn5ugz3pMk6ilp1C6e/GSA4ZcnVYH2UeMy+MgVFt+TRaKF2Xlrp9pheUXpiej
         RgwApm+pGHite9L/QA8Hy25ryz+Zfd9ruEiTC+uFqKldui3jsfZ8W26PKJWVPVYgHHCB
         DzCOCojS1hkj1WCNXckZ4zSlqZEEoIIgFcjwYmQ4B7yQA9W2mKgCmSVw2QNFdEsOp4vF
         dBAYNt2Rgt1KmOkhtPanxKDKFIUXjny8Ke1WLS9aV/J9wdLOppD8t+iz/+FmrJUne8Zt
         B/1CkGYUCfczUCsDFQK6OZAWvYM4TrKD+Gu+GXpLHP5HYE5VLm6K2N1Qp64JLbS0b6i+
         jeUg==
X-Forwarded-Encrypted: i=1; AJvYcCXrFEFleH624wN+50YiZglaS3gxm8PtWKIgUOBiquDbJWzqO/vkxF3ptiq75PgFZ2DDI3uK58sbew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFItLY49v2ndkvkMNSqZ2WDAyq/l/YlfGtCZHettan2Sw26nje
	89U9Gzt9TVVVJChVnbRrxWDPZ9hfORHmWT4CviGqIrvZpGiNIoBwYoJg
X-Gm-Gg: ASbGncseJOpvrJXjMECAalRSbSaOPOjXYmx5WZWQXYtT7iz5hZljdMwtfWebb9vniP7
	2nQvpDmrEXUBhZEu0txea+vOniCvvPavCtcWCOA4ewvcO58PKICWwr0WayJO+Nh9jKwhS9vZMXa
	tIj/HVN2kgiswpkE+7lg9LlzgScsBy7FTXJ1knga2a+DUCUOuwAVN6Vz60Uxkm7kQxIqExXVe3/
	vw936AKfiZxPmfa7rtaimjXYyBQ1FYvSDfY5sudPSNUL174A2Qidcls54+anugQXItDv3eOck6M
	C8peGNATKByRTJSb4XfY4wQQTy4Rj22fIrCQv7MqwTSpE4TJ33HWpUT9sdChJCXar4Zs5zj2YVo
	Agm9HrdPyyU7c0LzDX/cnmoyzrwgzNS1SIvWD+du/F09XA1S2TeGfUBbvOrdH2lkL20IjceYv
X-Google-Smtp-Source: AGHT+IGy41LT8aj0/Xvj0W53yZvKvDn5c9ABQJxOklSZONmqbPHs8HNDAqrjQAZba3bO5xPU/Rodqg==
X-Received: by 2002:a05:600c:3511:b0:470:bcc4:b07c with SMTP id 5b1f17b1804b1-477308a8f36mr118541675e9.37.1762185230454;
        Mon, 03 Nov 2025 07:53:50 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c48de65sm161908635e9.1.2025.11.03.07.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:53:50 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com,
	agk@redhat.com,
	brauner@kernel.org,
	dm-devel@lists.linux.dev,
	ebiggers@kernel.org,
	kix@kix.es,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	milan@mazyland.cz,
	msnitzer@redhat.com,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] pm-hibernate: flush disk cache when suspending
Date: Mon,  3 Nov 2025 18:53:45 +0300
Message-ID: <20251103155345.1153213-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
References: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mikulas Patocka <mpatocka@redhat.com>:
> [PATCH 1/2] pm-hibernate: flush disk cache when suspending
> 
> There was reported failure that suspend doesn't work with dm-integrity.
> The reason for the failure is that the suspend code doesn't issue the
> FLUSH bio - the data still sits in the dm-integrity cache and they are
> lost when poweroff happens.

Thank you! I hope I will test this within 2 weeks.

-- 
Askar Safin

