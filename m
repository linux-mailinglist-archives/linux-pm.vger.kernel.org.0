Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3773D24DF26
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHUSM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 14:12:57 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40633 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUSM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 14:12:56 -0400
Received: by mail-ej1-f68.google.com with SMTP id o18so3346607eje.7;
        Fri, 21 Aug 2020 11:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkxu0l1FDB0fNKXRa7l7mAwt5dC9vA3jIO/hZyVVjR0=;
        b=A5UFobK656ReMK15SfuP/BNkIGNYxnHObi/l+9rj68cxBUQbfyQVi4DcOo9MB9piyM
         nx/PIso8wUoF3b/5D4xOlsH8acqrvaom+jGbPwvBQf/DXwA4Hou8vviIzw3ZqabRwYWt
         8kHlLc0IrZKBnN7xWJ9TjNhgIEj0XwEnH0HniODj1VoBlny5OTB3qS+Bn6yw8lkR6gW5
         H7S9zvnakK/nLsvKlr+kwMP8YKs1zdk7ZdGpt/XARpKr6tfMJHA5axbqh3GgecCqcl3D
         O4m2rcgI1P79gMbilTdzRMdzwKDuuzYdMbjm0VAlHuV3Sj8qZXoo2vKLyNuSKS/2wdbT
         mbaA==
X-Gm-Message-State: AOAM533dzHrSgbhJzk8z7ty3pdL89bkaQhSXJoJshzl28Jd7WWHAsgx0
        gDJksTxxjlS8PLB+84ME/jJjrkxl7n6BQvxg+VE=
X-Google-Smtp-Source: ABdhPJxaXo7qfCNNAYhs2JJ5QB4yXhur6Plu3NWRJjXSSr6sSpf/I4hI5lzbhJWkfhDRUQIcHXku1wkkDsZ6eetSvR0=
X-Received: by 2002:a17:907:385:: with SMTP id ss5mr3976698ejb.496.1598033574493;
 Fri, 21 Aug 2020 11:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200817083223.18697-1-yu.c.chen@intel.com>
In-Reply-To: <20200817083223.18697-1-yu.c.chen@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 Aug 2020 14:12:43 -0400
Message-ID: <CAJvTdK=8rMpr8_WMWUn=NGcvBOjAdf-AiROkVM596xUtz6LRcw@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Support Sapphire Rapids
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Already have this one.

thanks!

Len Brown, Intel Open Source Technology Center
