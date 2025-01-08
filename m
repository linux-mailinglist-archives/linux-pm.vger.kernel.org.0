Return-Path: <linux-pm+bounces-20081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B84A057B6
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 11:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B7F1881CC2
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CBA1F2361;
	Wed,  8 Jan 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1JKzxss"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C11F239A
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331094; cv=none; b=MgQT552Asz+QVUXp0qS5UsrpwwVP6JN+I6OLvx6JK98zuuWQoaPiAVa8AR/sto6yWGHSGpjn8P/+aKMaI/vkAa+xyje5Zasq938AKPKxb9+KOA5Wh74dWeMu6+/yq+eoiJiVGn7hTYZqCSZ1VPFhHCEypON7IIqu1MD0c99qorI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331094; c=relaxed/simple;
	bh=V/ODiqx6lSN6v6R7XAgi/hRhq55t9qjxIjsedGlQvf4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tIbOYbeD+ankcgCTP/F2RkxYA0tPejCMq7pc60FYdMnTfSOzRs1nzqyhklFZASXpEHLhwu5KdaG8PiQLQlVwHy8F6S83saniAulJHkmdg1YNpcGzgR63p8C4i1GKs7ztbTOi4KbfzpMm9RI0NetgnfzrMjSUZ2eqka5+CLKf0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U1JKzxss; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361f664af5so186779575e9.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 02:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736331091; x=1736935891; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfocNC5rbJkIXXsevw8huXL/v/MR8+aYLX1nFm/Zrjk=;
        b=U1JKzxss8gIT8SUfwt9GyoP0mn9YHXk/ZKyFokBoLtJXqZ+3mncMksR+Yb68CSRR/e
         yUWkRB8X8SphIOEISVOAqwjqmXq9I9rC5yWl1400AOVJnGj5UCza79WSvq9Lj++O2qzW
         d13geWYCPvbxXmM/cVY7ruV6Hwgc2Zla/QSK5SGSsEpeuKMLaMT+TPlM78Agqq21FlAh
         85mnqsWbhpdMR2aDzEuuGQ0Ooc6AWJqito13TqxIzkg3cRxAndV8CqF/QElV41D1okco
         l38/1WlNkPwi2neq2y4RdxeQP9ZhTkqJbfLwO/NBNiYH4ep39y7w2uWDf/pjRdiyHIYV
         a+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736331091; x=1736935891;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfocNC5rbJkIXXsevw8huXL/v/MR8+aYLX1nFm/Zrjk=;
        b=TfBelW9/pEsxS9+TLpBPtYfWslVkpXTapyICDntgOMlJwkK3IcnT5gYzYoaIW17dI2
         VSg7am450k4TfDKQE2Eo9iZZ5OalV5IoHG5fPu+fltYgJ1GuNdfEpbLJI3+vNh5NK+z+
         dAl/bMty9SA77z66TMt5NbUOeFZ6umUms60f890I1rlLY2gimVeRF7XNqhk/TqrXhAAS
         uUk96QllHHWW4BCrcN88nJgqGNHnztLlQXhFk1var3kJVCwRg/0LorXoCnyyav0zk4X0
         FSYDKSf9fRRzfOD2PwbX4gn4zlc02VkISZdSoZjzQI7KXPNeb9+z9rROZQwcQQF0bb6D
         yheQ==
X-Gm-Message-State: AOJu0YxhIES7JiA349YF2tn1se++fdEG4n/C/FD6QFaTG8L6lXmmg2/6
	71eEFQnV7jSx0K8mT9vbuCGCFpEkgjztVRF6GukoixKHO6f7dSaGN3WYslXzzQjXDu7XneZzUhR
	E
X-Gm-Gg: ASbGncsrx9sDpSywoMne53BZoN9ORWa36x8Bsd7iGIhRT28cOCfSRjPpBoPzWwv2Ykc
	XCHSFvhQTlanceUOUv3CtQwY/RxN9c3xJaTGHfThIZCfZTnbp2rTcujZgmgsaOlaW0TEZghwMRF
	DhYKREGda/vl1Ame0xmQNlWamXTAu71rSz4FQsCdsnk4+E/dzQ2U85d262ymNvu+RHzVtS7c47j
	PetsiFkj8xCzdvXQwAfcVA0isVgYukxZsyJDlSvvejBgCE00s09KjSlmbn2+w==
X-Google-Smtp-Source: AGHT+IEfMwn3gsc0GjwldsXntX37dKdwhWb/58LpUp3fzw2Qv5Ak5yD04T4qeQdnsM9vU+2SnFLVwg==
X-Received: by 2002:a05:600c:1ca5:b0:436:1971:2a4 with SMTP id 5b1f17b1804b1-436e26c3efamr18429545e9.17.1736331090665;
        Wed, 08 Jan 2025 02:11:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc08eesm15605805e9.10.2025.01.08.02.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 02:11:30 -0800 (PST)
Date: Wed, 8 Jan 2025 13:11:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] powercap: balance device refcount in
 powercap_register_control_type()
Message-ID: <97c5c93d-e31e-483b-83c3-28b797b69e9a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Joe Hattori,

Commit cae442480e40 ("powercap: balance device refcount in
powercap_register_control_type()") from Dec 15, 2024 (linux-next),
leads to the following Smatch static checker warning:

	drivers/powercap/powercap_sys.c:632 powercap_register_control_type()
	warn: freeing device managed memory (UAF): 'control_type'

drivers/powercap/powercap_sys.c
    622         }
    623         mutex_init(&control_type->lock);
    624         control_type->ops = ops;
    625         INIT_LIST_HEAD(&control_type->node);
    626         control_type->dev.class = &powercap_class;
    627         dev_set_name(&control_type->dev, "%s", name);
    628         result = device_register(&control_type->dev);
    629         if (result) {
    630                 put_device(&control_type->dev);

The patch adds this call to put_device() based on static analysis but
I'm pretty sure that will lead to a double free so the patch should be
reverted.

We can see on line 626 that the class is powercap_class, so
put_device() will call powercap_release().  The means that control_type
will be freed.

    631                 if (control_type->allocated)
--> 632                         kfree(control_type);

Use after free and double free.

    633                 return ERR_PTR(result);
    634         }
    635         idr_init(&control_type->idr);
    636 
    637         mutex_lock(&powercap_cntrl_list_lock);
    638         list_add_tail(&control_type->node, &powercap_cntrl_list);
    639         mutex_unlock(&powercap_cntrl_list_lock);
    640 
    641         return control_type;
    642 }

regards,
dan carpenter

