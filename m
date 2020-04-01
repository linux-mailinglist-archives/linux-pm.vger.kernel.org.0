Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4399D19AE53
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 16:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgDAOyb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 10:54:31 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39228 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732911AbgDAOyb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 10:54:31 -0400
Received: by mail-wr1-f48.google.com with SMTP id p10so394079wrt.6
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2020 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IQMe16W4XUQz1uM1yCgGm9ngpz2Knic3ODqyYxMwk6A=;
        b=f5l8cLN8qQq0ORW0mMyX6PZ6Ymg1iC8FIDc1UErvetircKKseizhUFnahGDsLT0xWt
         jPko0mUkGTUKm7Bok0IS51O8XADL2bEM0kCGmMeqLgIw1FBLUwsu0WuYCHhDG/pS47BQ
         wXfdDYgNsNi+zwl3vh09YkXyssEt9/akcQPR1U3lDqkknFT78YuU3Dc9zQu/X+0vVmpq
         F68S0SwiWATwval7u4PjYvQBReZBV4MUd9nPd3bqJziXagPcD/wWjRypCF2iBrV+IDAu
         vWxWA7B/AnurFqBrQ235Xo4AcwDWC+GtM6Sq0fqkVjVm54RpWos4Bvs3rKjHzgqQLwpm
         0sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IQMe16W4XUQz1uM1yCgGm9ngpz2Knic3ODqyYxMwk6A=;
        b=GRDHabeuA7HDgOb2LwwIklk94GzqS1F9A4HIDC24mNFrj/upW4rAL7ipSh55/s8eXg
         VJHXqFyPLaJZ5wb6NeeA1aI7mt5udZ9NNZ05/T+udljA1/caGgEHCUMpxd9U2rL6e6ps
         AS9nUiD9UxpXMuiH53lVPzovm0HhwMXHHWzgaAQAbkjJTimizqHrK9EoB2wmnac/7dKz
         EsVkOhl2PAbIhTMpFt2+9HdAzZpGVcuJL1QaosF0ziITbggCW6Qfq1ktym18Uw0SviAV
         VEQEVt/2QPrjegQDF3lwIUvkJ1tErVE8ejSObhCvCNqjmky+HAWP7qOAqLi++/tMKDdg
         lVuw==
X-Gm-Message-State: ANhLgQ1TnBm1jivMn0Pnkl6VC3oy4qAgyXZWc4H9KH3sBaY1t9mZFS+P
        1yCmP8bZ0W5ipE17GjZ936MHDP/zjYHswOS3xL29CT4r
X-Google-Smtp-Source: ADFU+vs6xg2dzrxgSW/Vh9vBI/M3IdhOqav/Gjod5mTwVP5SuXlZehvp0EjBpf8LrQpu3q5rgAJzQ4wz5BcZm3R8iMw=
X-Received: by 2002:a5d:6187:: with SMTP id j7mr27521402wru.419.1585752870173;
 Wed, 01 Apr 2020 07:54:30 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Apr 2020 10:54:19 -0400
Message-ID: <CADnq5_NUueBoEXcO_HBHqwrONnmoAvepBLwwxtQW7R=SuyoFfQ@mail.gmail.com>
Subject: runtime pm without pci or platform subsystem involvement
To:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

  I would like to be able to use the runtime pm infrastructure to
support additional power savings at runtime for a PCIe device, but for
various reasons, I need to keep the device in D0.  I don't want the
PCI or platform subsystem to put the device into D3hot/cold.  Is this
possible?  If so how?  I'd like to avoid spinning my own variant of
runtime pm just to support this feature.

Thanks,

Alex
