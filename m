Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4332645F302
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 18:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhKZRew (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 12:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhKZRcw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 12:32:52 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5F1C0613FB
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 09:08:38 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id k23so20052579lje.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 09:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Z+Aa1ZVdAmfmE1NZueegBa8Pgcv0C9VgAhOiglDc9I=;
        b=ZgT2rO53QWWA4T0RU51wzkspW3t6DB3im0TxMixGFFCykR6O4rf1HhVCQsm+5pyQRq
         NTUqJQL/9wuqXdKDACOwwdRZB6f52wftNv+I7a1B+Gs8ddnlmdAh4XkRhniBGEvblYBm
         h215o983fRGfRNjXtHlyihN/e0+zqE6HLCUeAJFOdBAoNkmvrkqqnOdKMJLYIH1xXlva
         B8uhkYmluQ229tsBL6Q0Dtqq8Nz/XSeeN5yERhlSVOUO8LPZq+MogNloXed4fKzQp5zH
         LwMWkhddK2F5Lsznv+w93jCSC4YiMzPsLeYaO8n3oXgjPQohK/fVvJBboWsXzjdrCXHc
         HiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Z+Aa1ZVdAmfmE1NZueegBa8Pgcv0C9VgAhOiglDc9I=;
        b=SLWhl3OyyuxN9OMk8Iw8h18ZoRgErJgevVPfZMi/CViuTiTCYjXDl01LJ+dfoLi+Ol
         cXbHt0XMs2yfBybp7q0vt0zw4MDP3IVLM4abMAx8f934AEdP0QmowVWbTeKqiDF7RsYI
         Om/J7szteJCL6l7fekDYJA8cCcaPTeW4aJY9gBmeTnRG7+NN58wk6sFxosvCA4BrnWgi
         oYPJZEm1O9XZ8RdojFU06Ui2kQQHauL9om9BFSk+jhLIXzMQVHiMLGXxk7yXWcm2Q5kj
         8Q/kYFxrHCQ65bWKxgJ58oFvi2qOCpQ7YCXoVX2KxpgiepsTBs6ml3PwGwaHfv7WX8lh
         dEDQ==
X-Gm-Message-State: AOAM531pOl5qjxNKAgt0O7OKpavE+UCLUrXvSSMVLrhsRL2SThSxuqVL
        eZJYq9lfqufejMR8ICtkfG8lxnprS0C9yNE0f4dQFQ==
X-Google-Smtp-Source: ABdhPJxnCbmTYEOAlJ+sG03DlIEvE0POZPGX965bV4Wm9rt0oNTDOocOUUyNHGe2xNvUiK7m0R6T4BF7N3ner6BxgAQ=
X-Received: by 2002:a2e:80cf:: with SMTP id r15mr32902356ljg.34.1637946516629;
 Fri, 26 Nov 2021 09:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20210401183654.27214-1-daniel.lezcano@linaro.org> <20210401183654.27214-3-daniel.lezcano@linaro.org>
In-Reply-To: <20210401183654.27214-3-daniel.lezcano@linaro.org>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 26 Nov 2021 09:08:25 -0800
Message-ID: <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lukasz.luba@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        gregkh@linuxfoundation.org, dsmythies <dsmythies@telus.net>
Content-Type: multipart/mixed; boundary="00000000000049780205d1b424f6"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--00000000000049780205d1b424f6
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

This patch introduces a regression, at least on my test system.
I can no longer change CPU frequency scaling drivers, for example
from intel_cpufreq (A.K.A intel_pstate in passive mode) to intel_pstate
(A.K.A. active mode). The task just hangs forever.

I bisected the kernel and got this commit as the result.
As a double check, I reverted this commit:
7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
on kernel 5.16-rc2 and the issue was resolved.

While your email is fairly old, I observe that it was only included as of
kernel 5.16-rc1.

Command Example that never completes:

$ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status

syslog excerpt attached.

... Doug

On Thu, Apr 1, 2021 at 12:24 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The dtpm table is an array of pointers, that forces the user of the
> table to define initdata along with the declaration of the table
> entry. It is more efficient to create an array of dtpm structure, so
> the declaration of the table entry can be done by initializing the
> different fields.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/powercap/dtpm.c     |  4 ++--
>  drivers/powercap/dtpm_cpu.c |  4 +++-
>  include/linux/dtpm.h        | 20 +++++++++-----------
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index a707cc2965a1..d9aac107c927 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -583,7 +583,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
>
>  static int __init dtpm_init(void)
>  {
> -       struct dtpm_descr **dtpm_descr;
> +       struct dtpm_descr *dtpm_descr;
>
>         pct = powercap_register_control_type(NULL, "dtpm", NULL);
>         if (IS_ERR(pct)) {
> @@ -592,7 +592,7 @@ static int __init dtpm_init(void)
>         }
>
>         for_each_dtpm_table(dtpm_descr)
> -               (*dtpm_descr)->init(*dtpm_descr);
> +               dtpm_descr->init();
>
>         return 0;
>  }
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 9deafd16a197..74b39a1082e5 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -204,7 +204,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>         return ret;
>  }
>
> -int dtpm_register_cpu(struct dtpm *parent)
> +static int __init dtpm_cpu_init(void)
>  {
>         int ret;
>
> @@ -241,3 +241,5 @@ int dtpm_register_cpu(struct dtpm *parent)
>
>         return 0;
>  }
> +
> +DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init);
> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
> index 577c71d4e098..2ec2821111d1 100644
> --- a/include/linux/dtpm.h
> +++ b/include/linux/dtpm.h
> @@ -33,25 +33,23 @@ struct dtpm_ops {
>         void (*release)(struct dtpm *);
>  };
>
> -struct dtpm_descr;
> -
> -typedef int (*dtpm_init_t)(struct dtpm_descr *);
> +typedef int (*dtpm_init_t)(void);
>
>  struct dtpm_descr {
> -       struct dtpm *parent;
> -       const char *name;
>         dtpm_init_t init;
>  };
>
>  /* Init section thermal table */
> -extern struct dtpm_descr *__dtpm_table[];
> -extern struct dtpm_descr *__dtpm_table_end[];
> +extern struct dtpm_descr __dtpm_table[];
> +extern struct dtpm_descr __dtpm_table_end[];
>
> -#define DTPM_TABLE_ENTRY(name)                 \
> -       static typeof(name) *__dtpm_table_entry_##name  \
> -       __used __section("__dtpm_table") = &name
> +#define DTPM_TABLE_ENTRY(name, __init)                         \
> +       static struct dtpm_descr __dtpm_table_entry_##name      \
> +       __used __section("__dtpm_table") = {                    \
> +               .init = __init,                                 \
> +       }
>
> -#define DTPM_DECLARE(name)     DTPM_TABLE_ENTRY(name)
> +#define DTPM_DECLARE(name, init)       DTPM_TABLE_ENTRY(name, init)
>
>  #define for_each_dtpm_table(__dtpm)    \
>         for (__dtpm = __dtpm_table;     \
> --
> 2.17.1
>

--00000000000049780205d1b424f6
Content-Type: text/plain; charset="US-ASCII"; name="syslog_example.txt"
Content-Disposition: attachment; filename="syslog_example.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kwgn0tbv0>
X-Attachment-Id: f_kwgn0tbv0

Tm92IDI2IDA3OjMxOjEzIHMxOSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBVcGRhdGUgVVRNUCBhYm91
dCBTeXN0ZW0gUnVubGV2ZWwgQ2hhbmdlcy4KTm92IDI2IDA3OjMxOjEzIHMxOSBzeXN0ZW1kWzFd
OiBTdGFydHVwIGZpbmlzaGVkIGluIDEwLjc4OHMgKGZpcm13YXJlKSArIDEyLjM1MXMgKGxvYWRl
cikgKyAxLjgwOHMgKGtlcm5lbCkgKyAxbWluIDM4LjA0N3MgKHVzZXJzcGFjZSkgPSAybWluIDIu
OTk1cy4KTm92IDI2IDA3OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgwMjZdIElORk86IHRh
c2sgdGVlOjEyNzAgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDIwIHNlY29uZHMuCk5vdiAyNiAwNzoz
MTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4MDY5XSAgICAgICBOb3QgdGFpbnRlZCA1LjE1LjAt
cmMxLW4xMyAjOTc3ICAgPDw8PCAxM3RoIGtlcm5lbCBvZiBiaXNlY3Rpb24KTm92IDI2IDA3OjMx
OjU4IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgwOTZdICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVs
L2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KTm92IDI2IDA3
OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgxMzVdIHRhc2s6dGVlICAgICAgICAgICAgIHN0
YXRlOkQgc3RhY2s6ICAgIDAgcGlkOiAxMjcwIHBwaWQ6ICAxMjY5IGZsYWdzOjB4MDAwMDQwMDAK
Tm92IDI2IDA3OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgxNDFdIENhbGwgVHJhY2U6Ck5v
diAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4MTQ1XSAgX19zY2hlZHVsZSsweGNl
OS8weDEzZjAKTm92IDI2IDA3OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgxNTVdICA/IF9f
c2xhYl9mcmVlKzB4MjE3LzB4NDAwCk5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQu
NTY4MTYyXSAgPyBfX3NsYWJfZnJlZSsweDIxNy8weDQwMApOb3YgMjYgMDc6MzE6NTggczE5IGtl
cm5lbDogWyAgMTQ0LjU2ODE2N10gID8gcmFkaXhfdHJlZV9sb29rdXArMHhkLzB4MTAKTm92IDI2
IDA3OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgxNzJdICA/IGlkcl9maW5kKzB4Zi8weDIw
Ck5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4MTc3XSAgPyBnZXRfd29ya19w
b29sKzB4MmQvMHg0MApOb3YgMjYgMDc6MzE6NTggczE5IGtlcm5lbDogWyAgMTQ0LjU2ODE4Ml0g
IHNjaGVkdWxlKzB4NjcvMHhlMApOb3YgMjYgMDc6MzE6NTggczE5IGtlcm5lbDogWyAgMTQ0LjU2
ODE4N10gIHNjaGVkdWxlX3RpbWVvdXQrMHgyMDAvMHgyOTAKTm92IDI2IDA3OjMxOjU4IHMxOSBr
ZXJuZWw6IFsgIDE0NC41NjgxOTFdICA/IGZyZXFfcW9zX2FwcGx5KzB4MmQvMHg1MApOb3YgMjYg
MDc6MzE6NTggczE5IGtlcm5lbDogWyAgMTQ0LjU2ODE5OF0gIHdhaXRfZm9yX2NvbXBsZXRpb24r
MHg4Yi8weGYwCk5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4MjAyXSAgY3B1
ZnJlcV9wb2xpY3lfcHV0X2tvYmorMHg0ZC8weDkwCk5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVs
OiBbICAxNDQuNTY4MjA3XSAgY3B1ZnJlcV9wb2xpY3lfZnJlZSsweDEyZi8weDE2MApOb3YgMjYg
MDc6MzE6NTggczE5IGtlcm5lbDogWyAgMTQ0LjU2ODIxMV0gIGNwdWZyZXFfcmVtb3ZlX2Rldisw
eDkxLzB4YjAKTm92IDI2IDA3OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgyMTZdICBzdWJz
eXNfaW50ZXJmYWNlX3VucmVnaXN0ZXIrMHg5ZC8weDEwMApOb3YgMjYgMDc6MzE6NTggczE5IGtl
cm5lbDogWyAgMTQ0LjU2ODIyM10gIGNwdWZyZXFfdW5yZWdpc3Rlcl9kcml2ZXIrMHgzNS8weGQw
Ck5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4MjI3XSAgc3RvcmVfc3RhdHVz
KzB4MTAyLzB4MWMwCk5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4MjMyXSAg
a29ial9hdHRyX3N0b3JlKzB4Zi8weDIwCk5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAx
NDQuNTY4MjM3XSAgc3lzZnNfa2Zfd3JpdGUrMHgzYi8weDUwCk5vdiAyNiAwNzozMTo1OCBzMTkg
a2VybmVsOiBbICAxNDQuNTY4MjQyXSAga2VybmZzX2ZvcF93cml0ZV9pdGVyKzB4MTM1LzB4MWMw
Ck5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4MjQ2XSAgbmV3X3N5bmNfd3Jp
dGUrMHgxMWQvMHgxYjAKTm92IDI2IDA3OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgyNTNd
ICB2ZnNfd3JpdGUrMHgxYTcvMHgyOTAKTm92IDI2IDA3OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0
NC41NjgyNTZdICBrc3lzX3dyaXRlKzB4NjcvMHhlMApOb3YgMjYgMDc6MzE6NTggczE5IGtlcm5l
bDogWyAgMTQ0LjU2ODI1OV0gIF9feDY0X3N5c193cml0ZSsweDFhLzB4MjAKTm92IDI2IDA3OjMx
OjU4IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgyNjFdICBkb19zeXNjYWxsXzY0KzB4NTkvMHhjMApO
b3YgMjYgMDc6MzE6NTggczE5IGtlcm5lbDogWyAgMTQ0LjU2ODI2OF0gID8gdmZzX3dyaXRlKzB4
MWE3LzB4MjkwCk5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4MjcxXSAgPyBl
eGl0X3RvX3VzZXJfbW9kZV9wcmVwYXJlKzB4M2QvMHgxYzAKTm92IDI2IDA3OjMxOjU4IHMxOSBr
ZXJuZWw6IFsgIDE0NC41NjgyNzddICA/IGtzeXNfd3JpdGUrMHg2Ny8weGUwCk5vdiAyNiAwNzoz
MTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4MjgwXSAgPyBzeXNjYWxsX2V4aXRfdG9fdXNlcl9t
b2RlKzB4MjcvMHg1MApOb3YgMjYgMDc6MzE6NTggczE5IGtlcm5lbDogWyAgMTQ0LjU2ODI4M10g
ID8gX194NjRfc3lzX3dyaXRlKzB4MWEvMHgyMApOb3YgMjYgMDc6MzE6NTggczE5IGtlcm5lbDog
WyAgMTQ0LjU2ODI4Nl0gID8gZG9fc3lzY2FsbF82NCsweDY5LzB4YzAKTm92IDI2IDA3OjMxOjU4
IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgyOTFdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUrMHg0NC8weGFlCk5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4Mjk2XSBS
SVA6IDAwMzM6MHg3ZmNhNTUxY2ExZTcKTm92IDI2IDA3OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0
NC41NjgzMDBdIFJTUDogMDAyYjowMDAwN2ZmZmFkNDdhNmI4IEVGTEFHUzogMDAwMDAyNDYgT1JJ
R19SQVg6IDAwMDAwMDAwMDAwMDAwMDEKTm92IDI2IDA3OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0
NC41NjgzMDRdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDcgUkNY
OiAwMDAwN2ZjYTU1MWNhMWU3Ck5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4
MzA3XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDcgUlNJOiAwMDAwN2ZmZmFkNDdhN2IwIFJESTogMDAw
MDAwMDAwMDAwMDAwMwpOb3YgMjYgMDc6MzE6NTggczE5IGtlcm5lbDogWyAgMTQ0LjU2ODMwOV0g
UkJQOiAwMDAwN2ZmZmFkNDdhN2IwIFIwODogMDAwMDAwMDAwMDAwMDAwNyBSMDk6IDAwMDAwMDAw
MDAwMDAwMDEKTm92IDI2IDA3OjMxOjU4IHMxOSBrZXJuZWw6IFsgIDE0NC41NjgzMTFdIFIxMDog
MDAwMDAwMDAwMDAwMDFiNiBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAw
MDA3Ck5vdiAyNiAwNzozMTo1OCBzMTkga2VybmVsOiBbICAxNDQuNTY4MzEzXSBSMTM6IDAwMDA1
NWViMDNhNmY0YTAgUjE0OiAwMDAwMDAwMDAwMDAwMDA3IFIxNTogMDAwMDdmY2E1NTJhNThhMApO
b3YgMjYgMDc6MzI6MTMgczE5IHN5c3RlbWRbMV06IFN0b3BwaW5nIFNlc3Npb24gMSBvZiB1c2Vy
IGRvdWcuCk5vdiAyNiAwNzozMjoxMyBzMTkgc3lzdGVtZFsxXTogU3RvcHBpbmcgU2Vzc2lvbiAz
IG9mIHVzZXIgZG91Zy4KTm92IDI2IDA3OjMyOjEzIHMxOSBzeXN0ZW1kWzFdOiBTdG9wcGluZyBT
ZXNzaW9uIDQgb2YgdXNlciBkb3VnLgpOb3YgMjYgMDc6MzI6MTMgczE5IHN5c3RlbWRbMV06IFJl
bW92ZWQgc2xpY2Ugc3lzdGVtLW1vZHByb2JlLnNsaWNlLgouLi4KCg==
--00000000000049780205d1b424f6--
