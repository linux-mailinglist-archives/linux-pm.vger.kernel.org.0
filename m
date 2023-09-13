Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67A779DD1A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 02:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbjIMAXZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 20:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjIMAXZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 20:23:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EA91708
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 17:23:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58ee4df08fbso73808117b3.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 17:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694564600; x=1695169400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NbuxA4XotXcYUZUFiaKPRN05lv4PRo8Np/CcjXc+17o=;
        b=NIpsiQKOWS/7MY+TEzU2kDVaJo30KGmVInPyhmPnwRTniIrWT63z7KNPEaBAyRBNhc
         rYnl0XbscgLNV5DETlXcARxZcR54xdlbEHpRQuAhtxl2bjoic3f68fj0xzsgmYz5YYZv
         gHzhd1l0vNIIh0K59kmI7KBLa0ART1lCiXzcblCBPau0GCuT47j+jC3yDhA+gwXqGYdB
         ZRqV1V6W6hvyqr06i0utmr2v3NFuUqqJUfA0RPreCEpwN1b1cv+5m62KAyMNLjmxQ5xo
         c3AAwJl0ughmVIs982XSPGF8nVTIDdyR/gJh8yJpKlg8dyY2xqXMlYf5KRpa/XLRAJFE
         9zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694564600; x=1695169400;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbuxA4XotXcYUZUFiaKPRN05lv4PRo8Np/CcjXc+17o=;
        b=ZECbtv4n7bqWOQdqq9NyUQ4ezN/wIt8q10ycUdzChlim66twdaUqcnNzFfjZwraApP
         1fqTmiTgRil5H+itx3d+x8175NDFiWvqHV8KPBCDeD6AHwR4XH80hyxK0P3dmzSpCNOB
         zhR/pva4LuUKL01aWwDj/6bGHOJqZBj2/mv/UIrVVqKAJfDDg//ObdapVdlVhozP083z
         Slp1BWOv833VpEN+5fG1erPX+G0KvnPpyZHtCgPW0oP3t6sIxKXzLoLjhDwXVMmwGGA9
         941UQi59KNtd7ThA/ZnwkKGgcXWGfvTlzKslc62po0pHyzupRJ6GXcCnBmb8QsJrfJiL
         s/1g==
X-Gm-Message-State: AOJu0Ywq8jsD0eR0weZBLc23DkBi3WzJ9ADvuXFT8juTNwU1ndywHQP7
        PqjTFQgnFCKXprxFskUJgmCQkBd43ATzG7TDxw==
X-Google-Smtp-Source: AGHT+IEzZzx9zberWBT2WY6cLncjVWsBsFYEEHKmtQQiBe+cTrmgacI7YcfAfYsak67GLJNDGCXXcHpsKQ9WG8UEFw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:cb06:0:b0:d7b:9830:c172 with SMTP
 id b6-20020a25cb06000000b00d7b9830c172mr25636ybg.0.1694564600368; Tue, 12 Sep
 2023 17:23:20 -0700 (PDT)
Date:   Wed, 13 Sep 2023 00:23:19 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPYAAWUC/x2N0QrCMAxFf2Xk2UC7Cm7+isgoadwCo5akDmXs3
 60+Hc55uHcHYxU2uHY7KG9i8sxN/KkDWmKeGSU1h971wY0+oFXNVD6YVDZWQyovSStjqtOPk9V YuWWk4czRBfLhMkKbK8oPef+vbvfj+ALjgG25egAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694564599; l=1669;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=yxpoef4ix/G3dD6wBzM61GengyvUb1aXznzke49i5fE=; b=LK6YDxuF8xDLxBpgPtV7B8eVUfdzUg74U1QxP4sW23wn7GlIHROJup6YXorT5R5KwEtMdtf7a
 xvX/rN434SgC4Z4otmwC393s8l2VT12r1xLY05lp472xukUzvPsqb8+
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-cpuidle-dt_idle_states-c-v1-1-d16a0dbe5658@google.com>
Subject: [PATCH] cpuidle: dt: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer. With this, we can also drop
the now unnecessary `CPUIDLE_(NAME|DESC)_LEN - 1` pieces.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only
---
 drivers/cpuidle/dt_idle_states.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 12fec92a85fd..97feb7d8fb23 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -84,8 +84,8 @@ static int init_state_node(struct cpuidle_state *idle_state,
 	 *	replace with kstrdup and pointer assignment when name
 	 *	and desc become string pointers
 	 */
-	strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN - 1);
-	strncpy(idle_state->desc, desc, CPUIDLE_DESC_LEN - 1);
+	strscpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN);
+	strscpy(idle_state->desc, desc, CPUIDLE_DESC_LEN);
 	return 0;
 }
 

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230913-strncpy-drivers-cpuidle-dt_idle_states-c-c84ea03c1379

Best regards,
--
Justin Stitt <justinstitt@google.com>

