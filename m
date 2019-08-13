Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A268C44D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 00:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfHMWft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 18:35:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45523 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfHMWfs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 18:35:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so51984014pgp.12
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=mAGeWIXe6MQJuIUiTRMUvfwygGGoJcMf2QyhITXHXtg=;
        b=XJP8Xmhw7g0F4QLB73GBqerBE9NZmQRPXhIggC8smBOoGVgOJvr2tTSVGEUip/CQkg
         rI3XfMrRbRfDJwjHO9Jbhy3rShDvoIkjcC9BGB+vZ1aIwzn0/vlOWN4JjpV7FyKW1DSI
         y+5qBySuwVD/w4FyVJwvTZvOnuaZKKM1TxKa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=mAGeWIXe6MQJuIUiTRMUvfwygGGoJcMf2QyhITXHXtg=;
        b=uS7t5HYB9uHUqmnahTQavZR2A7C3+FPbsZ6tNc9XlCfzpCU+74mcwglyHz1hWMJd1u
         fSnJAxLx7NVHCApwNWumgjcFMVUe1iQZfWXET9zXc6alCu7XpdbyfPhJxWi6uVoRIlnN
         0OKp38zRGMQlQurOP7Wl7Sl+DklPZNjx1v6zUJNLQHv3lyJdpTAGhi+nafeIZvelLJ/F
         Is3zTPUBF6VVpYgjUDtr3IQZlsxVFCGvqu4Ph4lpMkmCiFt2VaICK2TgS9BWf/jLafdQ
         i2nehEjXdqCuvmloOpxEjWsSxQuYK1lEVIj+ldQkn5G5s1ezkxGVs4kJseLp9T5XVN3p
         bJrw==
X-Gm-Message-State: APjAAAXRFqpuuMgibku+NKPZh8lsmMbJ75FADS+F9sFIVWH1dRqf0uh2
        KEKapIHPyszUJLpTbU05akP9aQ==
X-Google-Smtp-Source: APXvYqzFvOWfUI7+1gDQANt2POJD2JCIPU+hftPOMda1R/K0iQXkeO8xTlGExJT8ZY8lMB0Ep4Ef4g==
X-Received: by 2002:a17:90a:d593:: with SMTP id v19mr4275052pju.1.1565735747820;
        Tue, 13 Aug 2019 15:35:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r13sm194208501pfr.25.2019.08.13.15.35.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 15:35:47 -0700 (PDT)
Message-ID: <5d533b43.1c69fb81.5729.a6bc@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1565731976.8572.16.camel@lca.pw>
References: <1565731976.8572.16.camel@lca.pw>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot warnings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 15:35:46 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Qian Cai (2019-08-13 14:32:56)
> The linux-next commit "PM / wakeup: Show wakeup sources stats in sysfs" [=
1]
> introduced some baddies during boot on several x86 servers. Reverted the =
commit
> fixed the issue.
>=20
> [1] https://lore.kernel.org/lkml/20190807014846.143949-4-trong@android.co=
m/
>=20
> [=C2=A0=C2=A0=C2=A039.195053][=C2=A0=C2=A0=C2=A0=C2=A0T1] serio: i8042 KB=
D port at 0x60,0x64 irq 1
> [=C2=A0=C2=A0=C2=A039.197347][=C2=A0=C2=A0=C2=A0=C2=A0T1] kobject_add_int=
ernal failed for wakeup (error: -2 parent:
> serio0)
> [=C2=A0=C2=A0=C2=A039.199845][=C2=A0=C2=A0=C2=A0=C2=A0T1] INFO: trying to=
 register non-static key.
> [=C2=A0=C2=A0=C2=A039.201582][=C2=A0=C2=A0=C2=A0=C2=A0T1] the code is fin=
e but needs lockdep annotation.
> [=C2=A0=C2=A0=C2=A039.203477][=C2=A0=C2=A0=C2=A0=C2=A0T1] turning off the=
 locking correctness validator.
> [=C2=A0=C2=A0=C2=A039.205399][=C2=A0=C2=A0=C2=A0=C2=A0T1] CPU: 12 PID: 1 =
Comm: swapper/0 Not tainted 5.3.0-rc4-
> next-20190813 #3
> [=C2=A0=C2=A0=C2=A039.207938][=C2=A0=C2=A0=C2=A0=C2=A0T1] Hardware name: =
HP ProLiant XL420 Gen9/ProLiant XL420
> Gen9, BIOS U19 12/27/2015
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1] Call Trace:
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0dump=
_stack+0x62/0x9a
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0regi=
ster_lock_class+0x95a/0x960
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
platform_driver_probe+0xcd/0x230
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
platform_create_bundle+0xc0/0xe0
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? i8=
042_init+0x4ec/0x578
> [=C2=A0=C2=A0=C2=A039.210606][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? do=
_one_initcall+0xfe/0x45a
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? ke=
rnel_init_freeable+0x614/0x6a7
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? ke=
rnel_init+0x11/0x138
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? re=
t_from_fork+0x35/0x40
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? is=
_dynamic_key+0xf0/0xf0
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? rw=
lock_bug.part.0+0x60/0x60
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
debug_check_no_obj_freed+0x8e/0x250
> [=C2=A0=C2=A0=C2=A039.219571][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0__lo=
ck_acquire.isra.13+0x5f/0x830
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
debug_check_no_obj_freed+0x152/0x250
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0lock=
_acquire+0x107/0x220
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
pm_relax.part.2+0x21/0xa0
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0_raw=
_spin_lock_irqsave+0x35/0x50
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0? __=
pm_relax.part.2+0x21/0xa0
> [=C2=A0=C2=A0=C2=A039.229491][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0__pm=
_relax.part.2+0x21/0xa0
> [=C2=A0=C2=A0=C2=A039.239588][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0wake=
up_source_destroy.part.3+0x18/0x190
> [=C2=A0=C2=A0=C2=A039.239588][=C2=A0=C2=A0=C2=A0=C2=A0T1]=C2=A0=C2=A0wake=
up_source_register+0x43/0x50

We shouldn't call wakeup_source_destroy() from the error path in
wakeup_source_register() because that calls __pm_relax() and that takes
a lock that isn't initialized until wakeup_source_add() is called. Can
you try this patch?

----8<----
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 3a7f5803aa81..f7925820b5ca 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -137,6 +137,13 @@ static void wakeup_source_record(struct wakeup_source =
*ws)
 	spin_unlock_irqrestore(&deleted_ws.lock, flags);
 }
=20
+static void wakeup_source_free(struct wakeup_source *ws)
+{
+	ida_free(&wakeup_ida, ws->id);
+	kfree_const(ws->name);
+	kfree(ws);
+}
+
 /**
  * wakeup_source_destroy - Destroy a struct wakeup_source object.
  * @ws: Wakeup source to destroy.
@@ -150,9 +157,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
=20
 	__pm_relax(ws);
 	wakeup_source_record(ws);
-	ida_free(&wakeup_ida, ws->id);
-	kfree_const(ws->name);
-	kfree(ws);
+	wakeup_source_free(ws);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_destroy);
=20
@@ -217,7 +222,7 @@ struct wakeup_source *wakeup_source_register(struct dev=
ice *dev,
 	if (ws) {
 		ret =3D wakeup_source_sysfs_add(dev, ws);
 		if (ret) {
-			wakeup_source_destroy(ws);
+			wakeup_source_free(ws);
 			return NULL;
 		}
 		wakeup_source_add(ws);
