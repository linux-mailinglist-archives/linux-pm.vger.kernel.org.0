Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8005C12EABA
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 21:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgABUBG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 15:01:06 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:50350 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgABUBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 15:01:06 -0500
Received: by mail-pj1-f74.google.com with SMTP id z12so4934058pju.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ARkancjaecOwC52/MajrESx5s7dn0KQR9/fZNXj0j2I=;
        b=jrdCSWCAWMNVE2OQRwzwzBb1NiikjCcGyKsZU4lGK8svAU5cjJtAnQm3RXt8DwKFA+
         nZjBozmagfuOFOd8DsEZblCmgYF/slGhlRx1y5enDV/Aj+OrY6EnpfE5TLV3FGG06OFu
         SEV4OaQ5/7qf7WY9DM54QE2UmsROV20rR8RkMB0baMbTTASt4RwkLLYUROZLDcp8btNz
         6jE9zXUHkCMDIVevDesxEAQpynYI0gPQJiO11noUpmkgTxMZWVGoa4jg21m+LLLnhp3o
         QonYYmEdmtnP0kWU5u4HLmXw3JdRkABeARDXTkw2pgddhljcHtkw8UVTswcNQBRCbUIg
         9cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ARkancjaecOwC52/MajrESx5s7dn0KQR9/fZNXj0j2I=;
        b=X7fpO5aN5nIRrwz1GRiz2V0LzKihh17cxvi1lcS2eJPD/aozpXQfbomS+NGTcciGIt
         hE6gYvXk+kGaEkJUBWvkMTJfnJ7fvNOe2JhPBHuhy9Y6mSWaBql3WCWDskSIFyEcJ/oG
         bb+28ue/KXc4F7PpxTO5P1ZCQFSvg9zvuiTUleVY852ees52scbYW1RfKspgu0YoxHdQ
         5zSS/Ymw7e3gWW+pvQAqaGRZZR+K+aLuQaxlUocFai2ZrBXUbh2yVhsZ5aAfZrAuLYTg
         pWVKJKq5jQB7YPh5ZNoVpEbiL+5ck1HInh2j5zY5hGb2sfmrAR3YGKsNRNiBrNvpJH0W
         0/1A==
X-Gm-Message-State: APjAAAV8rnnz4rkf8y93MDm8O8WdDFr+p7YLXIYx6oyYGBKAA3o1dMY8
        6fwwZdrLndcL9d/XFROxzrMJf/qdgWDc+0g7D6/WVFu101SI8/+eiq6n04tTyeDgY5Qxqnjh2SB
        DBcIX4Ym7hiB7EjrB9Q4iPVCpRhskfkN2WHfmm1uiBQjIdAJlOLIhDKSVSuM5Gli9H5rwH9mt
X-Google-Smtp-Source: APXvYqyIxOm6ba5eyO4OWWh7SR/elLe8fAPwip68Y6Gqul2zz00OiLehK8VMD0eVg5mjR5fHaBBJL46CoXBT64w=
X-Received: by 2002:a63:6507:: with SMTP id z7mr93919801pgb.322.1577995265520;
 Thu, 02 Jan 2020 12:01:05 -0800 (PST)
Date:   Thu,  2 Jan 2020 12:00:50 -0800
Message-Id: <20200102200052.51182-1-semenzato@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 0/2] clarify limitations of hibernation
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rafael@kernel.org, gpike@google.com,
        Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These patches aim to make it clearer under which circumstances
hibernation will function as expected.  They include one documentation
change, and one change which logs more information on failure to
enter hibernation.

Luigi Semenzato (2):
  Documentation: clarify limitations of hibernation
  pm: add more logging on hibernation failure

 Documentation/admin-guide/pm/sleep-states.rst | 12 +++++++++++-
 kernel/power/snapshot.c                       | 18 ++++++++++++------
 2 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

