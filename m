Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2516F460
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 01:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgBZAeX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 19:34:23 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:43603 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBZAeW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 19:34:22 -0500
Received: by mail-qk1-f172.google.com with SMTP id p7so1025320qkh.10
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 16:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=dcOce3PoshJ+NY86BbuLlniUku7fXlpuSXAZ8LGYJdw=;
        b=egLSHHnk9JOP89pQ+k1B3mbni7p4N0tKpBslDS2rPS1BjzYxUw8Ton4W8ZeKUfaCCa
         uybfbl+0gPLICpocoLH9Ag86nk2V29oEpjj4te8uRyqqzmMT3sIANuVIvIfi8Yyy3uAz
         balr9ZS2hcpP86kln1EavIcj/mo28FKW0nZLM9uBkHpQrO1wbrf8tSO3wF5NRsqqfjb0
         hBYHRaKdwbTjjodWlVbk6kk/4G6Hzbwrws8fCbSNtLGrb2LlkLxShUJlNfN1KytmPxDP
         mrFEhKmlGeOcb70AJ6K3tdR6dCnyO289dGsdXrJzkOnadWsiaP35kJwXmACJ/OzlLRFk
         hNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=dcOce3PoshJ+NY86BbuLlniUku7fXlpuSXAZ8LGYJdw=;
        b=KxsOxo1T9Zx4/2Xg0ZdSfQeLXtIx9DROUlJ4vzZLh6hP8DbAcwIXvTFoWdk9jJKWLE
         6RApP84mZSEbTyOM240oGANJODfgWcvOZVFk/uPkYcTMUDNyRNOiwo1X7tPXjg/5V+Bm
         wx0hypsg/9PFeiWh4vYTrQ14kkeKklYVSGNSW9L6Rd5L/OsKSOexTS8EaXXce9mVDQ5w
         d8efS73kw8naDcwlXTczVWnmT4+tj87UO300LuclyDhyjEvbLpKT5W4vK4cHwwVSLpWG
         9CENl3jzxGhz9YO9XiQMtUh3Oe3hPDrpHOOCgiGABS0G2pB0ftcs1Q+/t/JolZ22De9g
         XdCQ==
X-Gm-Message-State: APjAAAWou/GWc9iSgQwJ/rGsqKCy2nfIQyMrUsxzJr7Y4MsVLbEqQMvD
        atmKVovW1SQks5UeKerV468yRQ==
X-Google-Smtp-Source: APXvYqxpE+tID1QWX19eu18atq1kyUmwXoOU0fn0POXwu3rdeVE5y2Mb1HWpaN/jsxiDDo08DLz3lw==
X-Received: by 2002:a37:9b45:: with SMTP id d66mr2147082qke.84.1582677259776;
        Tue, 25 Feb 2020 16:34:19 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j4sm168618qkk.84.2020.02.25.16.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 16:34:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] power/qos: fix a data race in pm_qos_*_value
Date:   Tue, 25 Feb 2020 19:34:18 -0500
Message-Id: <705D8B35-FBB5-4D32-AE63-DD4E773CEC1E@lca.pw>
References: <CAJZ5v0jDjK63R4kbBb_aU7ZBXbCG_vfOW33aVBRbYV7hEOWYqA@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Marco Elver <elver@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAJZ5v0jDjK63R4kbBb_aU7ZBXbCG_vfOW33aVBRbYV7hEOWYqA@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Feb 25, 2020, at 7:10 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>=20
> The target_value field in struct pm_qos_constraints is used for
> lockless access to the effective constraint value of a given QoS list,
> so the readers of it cannot expect it to always reflect the most
> recent effective constraint value.  However, they can and do expect it
> to be equal to a valid effective constraint value computed at a
> certain time in the past (event though it may not be the most recent
> one), so add READ|WRITE_ONCE() annotations around the target_value
> accesses to prevent the compiler from possibly causing that
> expectation to be unmet by generating code in an exceptionally
> convoluted way.

Perfect. I=E2=80=99ll send a v2 for that unless you would like to squash it i=
n.=
