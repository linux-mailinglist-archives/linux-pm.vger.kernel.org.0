Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68B18C6C3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 06:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCTFXB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 01:23:01 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:33362 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgCTFXB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:01 -0400
Received: by mail-qk1-f171.google.com with SMTP id p6so5765744qkm.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhJVnI0DqcjPo+RjshehroaIdmZlkGl3rWbqE/8sd7I=;
        b=sXA8XiuLvAm61ig3pTi/Aw6PPnOjwiqqe9K6JWMPlPitfN11iOUFhPil6jpKnvXM14
         yC1FHHBMSHFRnvuVNRArwM6ST3a/babKOVs/wHpyK0584keaV2FIJecnkNULHh1Wftop
         /KfZqHJgCHYjGy+4Z+lqci8oC/2+MisvZIV87L7gBnRuLmhMU7PoHNLWUYzKOrmLxiJg
         RfNQZcLKNJsEGp+c0GTojMzm2Aiop5NCHnRoyRLfIprL/kYidyEs/ObhYGJzKE0H1QMb
         zyW7FvKT25nLd4WZopwyNxIBbWy+N8xKttjNrMb1JXUqoq4+HQb/DTx+xDN7k/KB0VMO
         G1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DhJVnI0DqcjPo+RjshehroaIdmZlkGl3rWbqE/8sd7I=;
        b=IAZ/5QZKYDKx4mrvUzfBGek9/wT5q2nGyD1pwV5SEhWYcGWXRYiWa8qMliBfdZShJH
         5Yqmvap7X2OPW38/4e8KdMhynZPrHN0VlMxxrwAsIM/gK9DlkX0Xzc1c7MCBRAA3WN1j
         eZ5qbGKur+lfa7BwCc5SpJjwSkBAcE7d0uI9/ngiBa64sVbG9jQhjwRucLFKETLZyttw
         dasRhP6ptPNdU447ZiYCqZrX/tNkVpn/nZ9EFvtlgMDE6VIo2qbvdG+dCBxjcpaNWTKH
         /aQRhnbp4YqlqPXreyq0pocQ7UfR+ehbU1FsDOjsq73d/VKa+hkZWUwx1Fb95A499P/p
         ux9A==
X-Gm-Message-State: ANhLgQ1V87HVYnIPQtoVThBRrut/4CclyeDmzbzExTpIO+fDLQLSB4iF
        mqXcQ7bbGCuXboF3j2mvomF1ozAf
X-Google-Smtp-Source: ADFU+vsjiaXDTSB8khPrA9ixQCQtcju51PUmSoA8uczPqPKgCb1dC53kOe3WLGjLyGAZcuR7CKoSWQ==
X-Received: by 2002:a37:bfc2:: with SMTP id p185mr5768115qkf.428.1584681779412;
        Thu, 19 Mar 2020 22:22:59 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.22.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:22:58 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Subject: turbostat update to version 20.03.19
Date:   Fri, 20 Mar 2020 01:22:38 -0400
Message-Id: <20200320052248.13037-1-lenb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Please let me know if you see any issues with these patches.

thanks!
-Len

[PATCH 01/10] tools/power turbostat: Support Cometlake
[PATCH 02/10] tools/power turbostat: Fix gcc build warnings
[PATCH 03/10] tools/power turbostat: Support Tiger Lake
[PATCH 04/10] tools/power turbostat: Support Ice Lake server
[PATCH 05/10] tools/power turbostat: Support Jasper Lake
[PATCH 06/10] tools/power turbostat: Support Elkhart Lake
[PATCH 07/10] tools/power turbostat: Fix missing SYS_LPI counter on
[PATCH 08/10] tools/power turbostat: Fix 32-bit capabilities warning
[PATCH 09/10] tools/power turbostat: Print cpuidle information
[PATCH 10/10] turbostat: update version


