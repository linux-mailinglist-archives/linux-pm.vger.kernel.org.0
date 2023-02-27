Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D676A4181
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 13:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjB0MO0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 07:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0MO0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 07:14:26 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4B410D7
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 04:14:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d30so24907758eda.4
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 04:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGTGRc09B4zPgk67dP6BDPLapL6pR3bqHR86efrMu/Q=;
        b=XhOSzcAoZoR9kPpANBf7uZVieB0zYBWS4Xb1uAWbKlvn6JnmIAemnd3y53aC/ZdzUk
         s1bx73ppuquPw8EC18/rqePrzF2MTyAsup+8ZvwP6blFovenwA4azysbvT2seW8C8+1E
         w0aoZpz+CIurQnGp/EJT30EyWMoxFyxlGo4Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGTGRc09B4zPgk67dP6BDPLapL6pR3bqHR86efrMu/Q=;
        b=OiNIlHp3IhCn4/iTA4z++KMAtOrcfQLJRr6KGK2ljCt1h5yqnRMYocTjhppEe6VNI/
         fIx81CJ/1hy8xho1JHjPhnKoXhj3lH78+Ctv3vzYztLEh7E5ZiTe0XntsramIscsc30X
         HTdT5k88DszJ2/i8nWxnrrYr7ZAAgNYX0SNtFUxbiaQFf2ZAARRC4EH9EaH+z0d/eXHG
         ArMlKgLMte1hhsjXkEpCkxr31e/PkWV0lSEPt9xuedr5Ktz9p3lOd+fYVDI6tma7U3wE
         5mZuGeOqKsgnU9uChu5DXqA0HOjii3v/8DLs+BdgfFgWl3VmSLquWiKwT/JdnsLCiEd7
         paCA==
X-Gm-Message-State: AO0yUKUtDHm2a64ZW08MqTiyihCxwbyUyIBg1D/e8kRA8E9eL8AzxHI+
        gpsD8q3Y86Orqn1tKXhzVkt5mggpY2e0FmW7TOc=
X-Google-Smtp-Source: AK7set9cxyN3U9EWTFD/LYGl1uK1Y3TJNyQ7M9Z5Eg0kYkzM0Rc8ewc9tn0H5SWuf5k4uuQZNyPmaw==
X-Received: by 2002:a05:6402:20c:b0:4ab:1d33:69ba with SMTP id t12-20020a056402020c00b004ab1d3369bamr23126461edv.16.1677500063143;
        Mon, 27 Feb 2023 04:14:23 -0800 (PST)
Received: from md.corp.google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id 30-20020a508e1e000000b00499b6b50419sm2994766edw.11.2023.02.27.04.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 04:14:22 -0800 (PST)
From:   Michal Dubiel <md@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, pavel@ucw.cz, Michal Dubiel <md@chromium.org>
Subject: [PATCH 0/2] Suppress warning on resume attempt of explicitly frozen processes
Date:   Mon, 27 Feb 2023 12:13:16 +0000
Message-Id: <20230227121318.2116638-1-md@chromium.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

The following patches disable warning message for thawing attempts of
processes that belong to a cgroup that has been intentionally frozen. This
happens in the following example situation:
1. A cgroup is frozen by writing "FROZEN" to freezer.state cgroupfs file.
2. System goes to suspend.
3. System resumes from suspension.
4. The cgroup is thawed by writing "TWAWED" to freezer.state cgroupfs file.

On 3, kernel tries to thaw the frozen processes. However, the processes of
the freezing cgroup should not be thawed in that step, but rather in 4,
when the user requests it. That is the case and kernel skips thawing of
the processes but it also warns about that it tried to thaw a process that
is in freezing state. It seems that the warning is not necessary for the
case explained above and the thawing of a process of freezing cgroup should
be just skipped. This exact scenario is common in ChromeOS, where a
separate daemon is used to freeze processes belonging to certain cgroups in
specific order before systems go to suspend and then waking them up after
system resumes.

The first patch of the series adds a function to check for the reason why
the task is freezing. That function is then used by the second patch to
suppress the warning for freezing cgroup's processes.

An alternative would be to simply add an "if (cgroup_freezing())" statement
directly in __thaw_task(). However, cgroup_freezing() does not check if
freezer is active (what the freezing() function does before calling
cgroup_freezing()). That would still work as the freezer is actually active
when __thaw_task() is called, but it would be more of a hack than a clean
solution. By having a dedicated function for obtaining the task's freezing
reason it can be done in a more clean way.

I would appreciate any comments or remarks.

Regards,
Michal

Michal Dubiel (2):
  kernel/freezer: Add routine to read task's freezing reason
  kernel/freezer: Don't warn when thawing freezing cgroup processes

 include/linux/freezer.h | 17 +++++++++++
 kernel/freezer.c        | 30 ++++++++++++++------
 2 files changed, 39 insertions(+), 8 deletions(-)

--
2.39.2.722.g9855ee24e9-goog

