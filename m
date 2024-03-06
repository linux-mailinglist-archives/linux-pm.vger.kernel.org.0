Return-Path: <linux-pm+bounces-4706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37EE872E5E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 06:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACA9B23BE9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 05:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FB917BCB;
	Wed,  6 Mar 2024 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yegcU/3w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797C1B7EA
	for <linux-pm@vger.kernel.org>; Wed,  6 Mar 2024 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703080; cv=none; b=iUbJpusLOBpP10IcXi3BB+OrG71EV4tHgcP8ihzbJPDumC5umZsNPt4v7XBR2+dPMGDcSH7iZRT09aIsvpm+IIgTjNl7O9oQYRjyYYyFC0TYUp32d2HVhhyG/9t1zIfndsnVt82FWmiQget8iPgoN4q1erR+6vky8r88sIAqpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703080; c=relaxed/simple;
	bh=e8JwpfH2qwx+HnHr4hdjW4ovgJO7lyNp72wzuJ1ReKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hqTJke3ABTBF+rxdCCMaLVcAN7rLj3KiMIwtN7fms8eXLCEAnB4dzUihv+beaCdk68fQ++u1eCeBbhxJCMLiLA10z8fhvJht8UKVKGvRQRcXymPSrqEz/pXxLyWffU8ctHWKr0rnpjQKuV+GF3JAaFUJLn/KgDEOLk5K0Utkp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yegcU/3w; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d28387db09so79714361fa.0
        for <linux-pm@vger.kernel.org>; Tue, 05 Mar 2024 21:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709703077; x=1710307877; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ivmi9EgRcMkcjUO21DjDPofnmdLcHS1kN6hp05JrX+A=;
        b=yegcU/3wBuk8hSb60IcQGfu1422EvI+HDFQjkVpYetb+qgrKFBJStlyRFsuGBDkrFP
         qJ8BWV1wcb2X1jMoyez5PxBFutE80nTTWgkX20v502PCWIAWFJbo5LzGrwwiV9R0d1BL
         Ujn7M+jhf7i1s62apmNo817rUdGMMwO83mVf6yv4zM+QO08+jyEhseZG0v6LOobnuVbp
         I/XOXokUZj2EAFc5181EJ72nVjhb56KMa7kK8l1ksBN+6sCYKgBHU382zLfsxD1x0TXN
         S6pcl5pmueUnrmysr0+n72NQuHrnA+0Yr8EEo3ntZI6WmxldoRW+8xHvXZeTJTSStSNu
         Ei5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709703077; x=1710307877;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivmi9EgRcMkcjUO21DjDPofnmdLcHS1kN6hp05JrX+A=;
        b=D2GJkaVEtbi/O8dcvuI7IzfBoMJ4WkBagKWIzLO/me/TL5gsMUGK3iPptirvO4ESzn
         jelLyFtz1KVutm0AHQvOTZe8RbIivChy+ps4fTZ6vt8NIpFjv6VAYHLHMbERa+xhsbPM
         bWdqFbq6spB7lIKmEtLYWf86ni0nalhZZRigunYliazuTKhyb2SzxkS2w3wSmzyDILXV
         +LrbpFL4tenkGrjhdjVwOzRfBe+MkuCUtXvdjPW4NPG+i9GVgj8sn07Ae2wKoKfPKE4S
         8fU7meO9m+BvVTELsIluzrTjAjnGMQeFS5+ZLZEuHrPKbX1DlH5djFxEB0GfDB1pmq8y
         qglA==
X-Forwarded-Encrypted: i=1; AJvYcCWoca2bBfATDQk9h0kJUNk2MD82kJF8b2Wr6DlRSKY4+UFcL0vmgv8apA/99NLp9OVj73i5Wsw58QmCWHu45vR5rPXQuJrEiYQ=
X-Gm-Message-State: AOJu0YxgBkIVs9gUVeLq5+zGmbtmKG0hIbEA8N2WMiTw14A0Bc95TOhL
	1qw+a2w7F0ZarY40bwxOTC7vOyxWbXKrNxThu8PTzjl2EeK3Obw26gIVNVBkMVw=
X-Google-Smtp-Source: AGHT+IHtDk/zN8qamO5T2ezKcWbmGSAbdouIyUYGl4G8wpORlh1ier2IgiPzw79t0QSYSHhV/9ZoNQ==
X-Received: by 2002:ac2:4188:0:b0:513:5d93:83ad with SMTP id z8-20020ac24188000000b005135d9383admr494662lfh.9.1709703076276;
        Tue, 05 Mar 2024 21:31:16 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c128f00b0041290cd9483sm22072535wmd.28.2024.03.05.21.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 21:31:16 -0800 (PST)
Date: Wed, 6 Mar 2024 08:31:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal: core: remove unnecessary check in
 trip_point_hyst_store()
Message-ID: <3332079a-9548-4b19-bba9-69270be115ec@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code was shuffled around a bit recently.  We no longer need to
check the value of "ret" because we know it's zero.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 7c02d35384ce..5b533fa40437 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -181,7 +181,7 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_unlock(&tz->lock);
 
-	return ret ? ret : count;
+	return count;
 }
 
 static ssize_t
-- 
2.43.0


