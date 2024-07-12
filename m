Return-Path: <linux-pm+bounces-11043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8703E92FC1F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA21F230E9
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 14:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53E616C69E;
	Fri, 12 Jul 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDRPSX02"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C821E49F
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793114; cv=none; b=FFhmrAF54pd6+MJcGRt9rqQegBiA/Qy/cMwEh704eJyR538QBOyxqaSBKQp2zc7EfEfr/Zy9CuQRYtVg8NSShYQgyJD7mDRyqKt4Z63h0QA3JX9R3QQ4UTg5RtykHL2KOqwBjD5jC9tm3aHJVu7BQvdmTb3R5OGXfgnrShcUC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793114; c=relaxed/simple;
	bh=vph4b1HyJ/YRRsqyAehEpZUNjGQvNzRYRdtfjF5jx4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LGP1ta69ex7YML4Td177feH3ox9YTOJjnT+RgPCRR+S9eNZykZfgbweTqVaGgnclK/lxukpkaIo+cqOFAKcCqNIfWWvhSvb9HUlpZXvP7m/H5XLw0D5GcFrQKJd/8zHoHxwoY/HIbYA05DieBuzR5DKxmOEiYVVgyhPdQrfvYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zDRPSX02; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70362cb061aso1077680a34.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793112; x=1721397912; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZ7M9BFwqc2+1y06wmG2qURLKsH3S436YqvAcW324NY=;
        b=zDRPSX02aQ853e0JPM5C4GGDedrAynhSBg5uWusJFbbij4CbUB3AcK06B/lW+cSEH2
         g7KPbJdmvNeEfNCM3LEY6v70nXn0kYN/M0e3MWxDIqBbDq4EPaMcQ5H0w1j28SHsHgbb
         pkS+g9mvAEw1f3voInzyh5CwiStU2ZiL8vzVGgUPkJJ3ZqWuMAx7dT/9Or76zXdMbfMp
         vij3BURO7yGSFrHQIsT3P2LDb0Xo/oXnDahjkyQPzdIJrRC7XgcnvqgHb+LKQXxMTqhe
         097941KJ+68ZHGGGBy1T0t0yfQMlN50GzjkkyCgUjK/XVLRKiywiiK30sXWx1Dvl0GiQ
         491Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793112; x=1721397912;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ7M9BFwqc2+1y06wmG2qURLKsH3S436YqvAcW324NY=;
        b=fvgeJHQpHh7sYH1ZZlQvawiZAhsUDzVk3+LZrcvj/hl3dD+qonPncdhsqmfkUBSn/m
         oQlG7l0Nro4O4+8O1LXFqJHs0myKq0jS6X6Fg5C0SA7rZhDpkMH+JWW45AKzpNQOe+/I
         HhQq/3NalEwrxTFEPg3Gvp6rJN3d3hfZrVJ6yI6PLFQ4ye1ywwy1Tj7FHOcles8D9JkY
         q+3ArXtjl2ZUAgBMswMqmgjqDsk81nQ9ZEH081aUsG4VBoBw5JmTMP9E9xl7zXqz7jlO
         IEIkVcHiZ1K87Q9h83D34QUuwCiEhjEO9daVTd9BFB7xcUJ/diHt5BD5dQhJsHWc+zjS
         0ZeA==
X-Gm-Message-State: AOJu0Yx6dd2JeSOUEIqPf/fiaDVEF5QSpY0XvO0JFveRMQFyeOL56Pd2
	MwkWZgAQSd1pK2ahnatUvm14ZiMBqgzY1f/9BgSyXy1aOIqZw/AXLaaG/ss/8Vo=
X-Google-Smtp-Source: AGHT+IFpqs8lH2qnWpVz0xtrPvFjjuhB1rlifQhyRlzuneYV66xV5r+yv/Ja2itZdGUUTaLsQ5Bq4w==
X-Received: by 2002:a9d:6d82:0:b0:703:5cf9:2968 with SMTP id 46e09a7af769-70375a1f058mr12932723a34.21.1720793112284;
        Fri, 12 Jul 2024 07:05:12 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374fc0b64sm1572219a34.64.2024.07.12.07.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:05:11 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:05:09 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] power: sequencing: implement the pwrseq core
Message-ID: <62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Bartosz Golaszewski,

Commit 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
from Jun 5, 2024 (linux-next), leads to the following Smatch static
checker warning:

	drivers/power/sequencing/core.c:435 pwrseq_do_setup_targets()
	error: 'target->unit' dereferencing possible ERR_PTR()

drivers/power/sequencing/core.c
    412 static int pwrseq_do_setup_targets(const struct pwrseq_target_data **data,
    413                                    struct pwrseq_device *pwrseq,
    414                                    struct radix_tree_root *processed_units)
    415 {
    416         const struct pwrseq_target_data *pos;
    417         struct pwrseq_target *target;
    418         int ret, i;
    419 
    420         for (i = 0; data[i]; i++) {
    421                 pos = data[i];
    422 
    423                 ret = pwrseq_check_target_deps(pos);
    424                 if (ret)
    425                         return ret;
    426 
    427                 target = pwrseq_target_new(pos);
    428                 if (!target)
    429                         return -ENOMEM;
    430 
    431                 target->unit = pwrseq_unit_setup(pos->unit, &pwrseq->units,
    432                                                  processed_units);
    433                 if (IS_ERR(target->unit)) {
    434                         ret = PTR_ERR(target->unit);
--> 435                         pwrseq_target_free(target);

We can't pass this target->unit to pwrseq_target_free() or it results in an
error pointer dereference.

    436                         return ret;
    437                 }
    438 
    439                 list_add_tail(&target->list, &pwrseq->targets);
    440         }
    441 
    442         return 0;
    443 }

regards,
dan carpenter

