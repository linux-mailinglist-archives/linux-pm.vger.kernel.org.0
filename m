Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCA71074D2
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfKVP1c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 10:27:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35665 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKVP1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 10:27:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so9116810wrw.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2019 07:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBh+C98xO+z8qsX915RR0pFfiuyA4L1CQVRjFLzavOE=;
        b=UFaFecI+e6XK8CQPbA6dCzXoCQ06/oN/oWaAhPOH1Qak+kbiErxtomFZ6fj4P7C9Zo
         3QX0sFM5e9uFdF9zuGQGx7l7Ps/PDPkMoBDOidrfjGJa/ujBhawqhB4Yu0prfQ3JvhOb
         XAOvNXeL9hiCSs6xfaStRiOAIRY9IQTi6+059rtxuPoSTk7s1aE2ezXaVtpEuhFptBUx
         4ZdgBqeOFwy2jWvsslYWbzd+NaHtOl9YxiljccQE2Z47s7NuAgSSbP36ZOYohtU1VuG2
         WNvmOhbrcOeaYo0vyIo2wn7LncEBuk89pu8MQTsxS5Te0dewt6/UbytRueHQ9lD65H4x
         hGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBh+C98xO+z8qsX915RR0pFfiuyA4L1CQVRjFLzavOE=;
        b=KBK6gkezN911/3eXMLo7l4ZYODSYBxPR0aIDnzLkETWI3zJQG9u74bJvbKtQm27MKc
         tz2qD/5SweWkts03bIOsHeeqwsdB/Gn/KW94I1beDDlXOgtVq+mr0SYBq1x0NLpg0QRK
         AwFBGA2KTT6uFNhZGrizmqz7OeQTZlxdZYtb8QcuJ4omOFe82UxZqjyKjBKmUD2+AKIo
         URlleeZKzSgx7/v/I6XDhSDN8uEprDlhyBWY1w6b7c7a1lFiw8jzFpunMPvTUCTy79Si
         k4juu7ugDkquUkZVPZmpAsAAtknKI5oL5w61uNiBolaNPCGTkGun4UfAB2BUFu+DMFK1
         vzIw==
X-Gm-Message-State: APjAAAVRypx0HI1xg4RVRTzGx39USZGTHKHVCKmnnb0GHlF0YIULg2va
        FzKiMYBumt8Y0vuyBpxlWT8n5ufn0Bs=
X-Google-Smtp-Source: APXvYqwi1bJWuQJ2ZyfSz6IK7AWXUIHOuNwTnYpwXJGni0c209ZDVHhlziX/ecY+BW5ZP9RiO7TvDQ==
X-Received: by 2002:adf:b193:: with SMTP id q19mr17173456wra.78.1574436434458;
        Fri, 22 Nov 2019 07:27:14 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a206sm4061081wmf.15.2019.11.22.07.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 07:27:13 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v3 0/3] interconnect: Add basic tracepoints
Date:   Fri, 22 Nov 2019 17:27:09 +0200
Message-Id: <20191122152712.19105-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tracepoints can help with understanding the system behavior of a
given interconnect path when the consumer drivers change their bandwidth
demands. This might be interesting when we want to monitor the requested
interconnect bandwidth for each client driver. The paths may share the
same nodes and this will help to understand "who and when is requesting
what". All this is useful for subsystem drivers developers and may also
provide hints when optimizing the power and performance profile of the
system.

v3: https://lore.kernel.org/r/20191101130031.27996-1-georgi.djakov@linaro.org
- In order to avoid #including a file with relative path, move the trace.h
  header into drivers/interconnect/. (Steven)

v2:
- Moved dev_name() into TP_fast_assign() to reduce cache footprint. (Steven)
- Added path name to traces (Bjorn)
- Added trace for path, device and ret. (Bjorn)

v1: https://lore.kernel.org/r/20191018140224.15087-1-georgi.djakov@linaro.org

Georgi Djakov (3):
  interconnect: Move internal structs into a separate file
  interconnect: Add a name to struct icc_path
  interconnect: Add basic tracepoints

 drivers/interconnect/Makefile   |  1 +
 drivers/interconnect/core.c     | 55 +++++++++-----------
 drivers/interconnect/internal.h | 42 +++++++++++++++
 drivers/interconnect/trace.h    | 90 +++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+), 31 deletions(-)
 create mode 100644 drivers/interconnect/internal.h
 create mode 100644 drivers/interconnect/trace.h

