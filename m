Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2885E18DDE5
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 05:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgCUExC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 00:53:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36205 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCUExC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2020 00:53:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id b18so9719028edu.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2020 21:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upj/Ui6y7TzAhYZbxDxqxre9H3yDUa4qe6Jw+AbLOzs=;
        b=crwBobZkNlbsnzBz5Ehvdo1cINUlYAHYewpDTmJgBZWxVA0J1vewb9HTiA6ytkCTV0
         uDiOknodplQeLAS7TD9VXayjVQlbdnNcLPFX0VA3clbnQL3tuSnqTAA8KKcMXQwaJMOD
         WNT1UG30JUbk87GIzerKw1o40OuxP4XvuFd1MaXClU5duLSsoAwlZrqT4oHz3ftqlupa
         Id6njWLdgId8/EKvnRsKkz2GEEl77kBZIh3PcKLDA5VUxVmt/Y16M14ZqL8iWeOT+Sha
         KgpsSLtxsACKs9ntU2BsUOklhRZGYVz3s5uZe8ntsw15m6qhhJS5VGMh460OEr8E0QjQ
         unRg==
X-Gm-Message-State: ANhLgQ1QYAmpUL7Prv7t+LFQIp/r897elVLhfGgcip+s4JB4o9iuUoSk
        tuepXVgGPKn+GRPvgscx6guK0xa4nYxsxtfqrXg=
X-Google-Smtp-Source: ADFU+vvM1RTN02MgVnRURhDCTTiJO1sGsuRmznklcnA7IF5vC307eYnLFj3dqeA1uXE0moQRbEq3T4NQlGoFbctC4MU=
X-Received: by 2002:a50:8e08:: with SMTP id 8mr854470edw.153.1584766380562;
 Fri, 20 Mar 2020 21:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
 <7c3808082a40a96e95808864fe814b4e68238a46.1584679387.git.len.brown@intel.com> <000001d5fecb$594be560$0be3b020$@net>
In-Reply-To: <000001d5fecb$594be560$0be3b020$@net>
From:   Len Brown <lenb@kernel.org>
Date:   Sat, 21 Mar 2020 00:52:49 -0400
Message-ID: <CAJvTdKnXOw2bE+QraC7nxeVCYOFX-9b63c5VYOsE0+fM_QfjXQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] tools/power turbostat: Print cpuidle information
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Antti Laakso <antti.laakso@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks, Doug, for reviewing the patch!

I'll send a replacement that is more flexible.

cheers,
-Len
