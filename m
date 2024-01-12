Return-Path: <linux-pm+bounces-2142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2599682BC40
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 09:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8933B28419F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32EC5B5C1;
	Fri, 12 Jan 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxxW+QZd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA15D8F3
	for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e629c5a42so11866405e9.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705047184; x=1705651984; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPwySn3Z88dZfJcCL0CuKfk8c4yySo4fGuuZPU5+jwI=;
        b=QxxW+QZdLo/4mF1EPT6PX12gchoSNKS+/XiikPK7WnV12sl392f3jcSso55fvRB0XE
         2oHBX+CpO8l9+K8UXUNtG16wQ8p+azJUqdmzB1pcmmCaWssGcbd0yjKfeFHyXGTGCe+g
         nxRQQWs16nW3ygUReSAaZW2zXUIoqJCgt02emGzOKYKYzomhHI5feE4TW4O/NCXXQVRA
         OBUBAiuUfgH1oRXhwSo2VJOKOnqHO1co1AziFgk71bH3edVVcCbQcNay3eJpk5K+9+2V
         VpOQUFtWTCAlpzBdgOO/US+2Xe3+NCVB7sCUVQEOX/2q+4VVKr1b0N834REcUTwa8FR+
         IAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705047184; x=1705651984;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPwySn3Z88dZfJcCL0CuKfk8c4yySo4fGuuZPU5+jwI=;
        b=k1u+vT62WocQXg+HRpzFWs9RFfhzEESXVPmZfElyAtoKX41yZX9J3YFIpp8Wavdoio
         Wp6RrHulog83OZRag5Cd9iETR7yf7ZJB5i2+fANqKyGuYjib4M4xJy1ZBqNfUHbiHaHH
         q4Zo4Qb/gnzmDl29My5Y3jDYNqp8qD5g0gGeK1zEIdsv0OjRw/w+kG+IszHwy3Pd3ao3
         oTMjlv6j9v/SmjE5lDRkRmB5WVdEzNKcTGh66VgP1A/+rzy0eDi1NvaurNSn+O0H2oDO
         9TOrIt7FKl03uLnN5JDJnbBBVl6jk1/8HeuZ5Fms0u9CzcUs5rku+NpbesRmYJd26TC9
         O8sg==
X-Gm-Message-State: AOJu0Yxh0wbtVpmER5GIr5sYvpzVCTyri0VYpwANLPFENEGaJniwAnWe
	8SIvuf+VcnA7lkveDG+2wj1f7CAxpqKgpw==
X-Google-Smtp-Source: AGHT+IEIzKPeC+lKVQ1FZi9GqUKPG8L0cOGRY6NeQKGmy9mvcca7XOrVmAUirKsijoIWD/NLV658EA==
X-Received: by 2002:a05:600c:214c:b0:40e:509c:36ec with SMTP id v12-20020a05600c214c00b0040e509c36ecmr504979wml.206.1705047184569;
        Fri, 12 Jan 2024 00:13:04 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id fa7-20020a05600c518700b0040e6792305asm686264wmb.16.2024.01.12.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 00:13:04 -0800 (PST)
Date: Fri, 12 Jan 2024 11:13:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org
Subject: [bug report] thermal/debugfs: Add thermal cooling device debugfs
 information
Message-ID: <ddde68fc-8693-42bd-bcff-c9ddbd1215c2@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Daniel Lezcano,

The patch 90f2fb4afe8b: "thermal/debugfs: Add thermal cooling device
debugfs information" from Jan 9, 2024 (linux-next), leads to the
following Smatch static checker warning:

drivers/thermal/thermal_debugfs.c:517 thermal_debug_cdev_remove() warn: 'thermal_dbg' was already freed. (line 515)
drivers/thermal/thermal_debugfs.c:835 thermal_debug_tz_remove() warn: 'thermal_dbg' was already freed. (line 833)

drivers/thermal/thermal_debugfs.c
    504 void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
    505 {
    506         struct thermal_debugfs *thermal_dbg = cdev->debugfs;
    507 
    508         if (!thermal_dbg)
    509                 return;
    510 
    511         mutex_lock(&thermal_dbg->lock);
    512 
    513         thermal_debugfs_cdev_clear(&thermal_dbg->cdev_dbg);
    514         cdev->debugfs = NULL;
    515         thermal_debugfs_remove_id(thermal_dbg);
                                          ^^^^^^^^^^^
Freed here.

    516 
--> 517         mutex_unlock(&thermal_dbg->lock);
                             ^^^^^^^^^^^^^^^^^^
Use after free.  Same issue in the tz remove() function.

    518 }

regards,
dan carpenter

