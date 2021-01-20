Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BCE2FDBD7
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 22:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbhATVZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 16:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbhATVYv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 16:24:51 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB75C0613C1;
        Wed, 20 Jan 2021 13:13:54 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 3so114463ljc.4;
        Wed, 20 Jan 2021 13:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9SzY+rPoitpU/eUZajfioFau9iWba75LSgb/vVzMO4=;
        b=jQQjUnLM/CnrijQRgSGWa5rrt5vBw3HYnIjcRsYyYCns8TvRDr6MRVxN3/7pcHXWQS
         SeQ0xJWvdEeTaBJYLgeRYPxpbSRXqA9B0dV2okMU4fEY9FflFgmDDGWqZ1QrGlM7azK3
         hIwuYOzb4uBaTWBIi6+LtM5GBJRpwJyCdcAZQyNJkp84/x/UEosyU8/ysnLCCDhUPul+
         R3REx9CoyWwbxgP62WK8qxhdKAFbZTrWyshiJOC+2VApSBNp34Rzh7GGJ10K3iJxsRYU
         PNTf9UcbIk/nLsNmrK11iML8OUlk9FIh9GXlqK8WYxupSvkRFMsEYjdRtztsBsHZe+Za
         5+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9SzY+rPoitpU/eUZajfioFau9iWba75LSgb/vVzMO4=;
        b=nlsRa9rWPqSB/j6z+meuJKck6meneDPFUJsrl67QHqDnz0DkotI+WjKtQ/FqMzFBsa
         bjuOFAH/Q0ooD4I4Nmkk3fshk28aK7raGuMUqDT0tPzDnDIo5cQIqaprs7v+Vk0xvMDY
         UxBmlnCu3ZJotskB6F5kyW0uJCQXPFOwz5hMGW+GKN7dIH1L0XvWPcSWp0OojbblEQXW
         wlN9+L111TFNZT7GDnB4N6TCUbJrwMHIjtA7XBKJd8VxKMAEgfADtaR4GaCJYj1fmG/z
         Cc9vgw0TaZPSlDOnvPblooWimJsPRduyntuLcFEzCpBqEvuXJmOjKH5KVcuqg1RKOS2E
         LWdA==
X-Gm-Message-State: AOAM532f1rx2LZTfA8y4Jgl4pfG3zxH/WUqERqKcn0rKgQazlW1OVMuE
        Nubs07kuXAamWUiro/b5Bs+uMFha/bI=
X-Google-Smtp-Source: ABdhPJwiEdk2TXuFXgvoQPSkujL9k026Rz/nUihP+1xfMlkG3UEBsW/2DSrrZGOho4YJsMpuoi7KMg==
X-Received: by 2002:a05:651c:112c:: with SMTP id e12mr5366946ljo.66.1611177232499;
        Wed, 20 Jan 2021 13:13:52 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id 196sm298131lfj.219.2021.01.20.13.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:13:52 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 2/3] PM: domains: Make of_genpd_add_subdomain() to return -EPROBE_DEFER
Date:   Thu, 21 Jan 2021 00:12:31 +0300
Message-Id: <20210120211232.17299-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120211232.17299-1-digetx@gmail.com>
References: <20210120211232.17299-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Driver of a power domain provider may not be ready at the time of
of_genpd_add_subdomain() invocation. Make this function to return
-EPROBE_DEFER instead of -ENOENT in order to remove a need from
power domain drivers to handle the error code specially.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
[tested on NVIDIA Tegra20/30/124 SoCs]
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5c843772f7f4..25b346bb2d97 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2466,7 +2466,7 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
 out:
 	mutex_unlock(&gpd_list_lock);
 
-	return ret;
+	return ret == -ENOENT ? -EPROBE_DEFER : ret;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
 
-- 
2.29.2

