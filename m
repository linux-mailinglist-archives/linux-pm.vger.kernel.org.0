Return-Path: <linux-pm+bounces-328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00B7FAFBF
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 02:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8142728140C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 01:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF951C2E;
	Tue, 28 Nov 2023 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C213138;
	Mon, 27 Nov 2023 17:48:07 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b837d974ecso3095293b6e.2;
        Mon, 27 Nov 2023 17:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701136086; x=1701740886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVr3F2hxQwUzP61DpYsFkJ3ETcJcTqVqqeZTUprliR8=;
        b=xUTX/z2Sw2rW1o/yVrd0h2yysRxMsGTGGdmgLoNCwfyaAAjnPj0nzrAPcvnAR+iERr
         EKyMNxR2RwZ/uwZvO2CemnjXOUauaE3YMjme9f2e5aPTqac6z81vKlsuNC4XkvPa64vq
         ljhfNGdhAM31tThyQsCOWBPJVWexyxLOcxEn1DpOc9DbjkMQSBAq2PrNsQihn+0Kua0l
         P2nbIEMhpaYrX2IbnTFPZamHb/kan2ReIUoajQQ33DLxqmxlUoTMUmY9rPoVnT8JjgX8
         EGTPgcp76JMpSWqKSVCSUj4DoaL22jvk6Tj+IQr9zDlgTI0ox5OIAmyvPTACd5iWMRzH
         Y77A==
X-Gm-Message-State: AOJu0YxeTV17EpdiEx9k8HV2eH9sBcwyyTkCx54ustoSP38FivdUS+lp
	rzEKbYeIapA6Qr5RAPFjjWv074ZL0irctc7eO5k=
X-Google-Smtp-Source: AGHT+IGvxNlGukeQgZNcXeGDTi+TJJ93S20Hj8BOi49VO0yFr6+9IKAW+lVKp5+sV6kNLbcACqkrXXBiDVMzccFfCUw=
X-Received: by 2002:a05:6871:296:b0:1fa:3b7d:1573 with SMTP id
 i22-20020a056871029600b001fa3b7d1573mr8676008oae.7.1701136086592; Mon, 27 Nov
 2023 17:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003050751.525932-1-wyes.karny@amd.com>
In-Reply-To: <20231003050751.525932-1-wyes.karny@amd.com>
From: Len Brown <lenb@kernel.org>
Date: Mon, 27 Nov 2023 20:47:55 -0500
Message-ID: <CAJvTdKnE4RW7fkHX2r6MvtrC80ynMazgP90KGi7Yump-s3-09g@mail.gmail.com>
Subject: Re: [PATCH v2] tools/power turbostat: Increase the limit for fd opened
To: Wyes Karny <wyes.karny@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied

Thanks Wyes!

On Tue, Oct 3, 2023 at 1:08=E2=80=AFAM Wyes Karny <wyes.karny@amd.com> wrot=
e:
>
> When running turbostat, a system with 512 cpus reaches the limit for
> maximum number of file descriptors that can be opened. To solve this
> problem, the limit is raised to 2^15, which is a large enough number.
>
> Below data is collected from AMD server systems while running turbostat:
>
> |-----------+-------------------------------|
> | # of cpus | # of opened fds for turbostat |
> |-----------+-------------------------------|
> | 128       | 260                           |
> |-----------+-------------------------------|
> | 192       | 388                           |
> |-----------+-------------------------------|
> | 512       | 1028                          |
> |-----------+-------------------------------|
>
> So, the new max limit would be sufficient up to 2^14 cpus (but this
> also depends on how many counters are enabled).
>
> Reviewed-by: Doug Smythies <dsmythies@telus.net>
> Tested-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
> v1 -> v2:
> - Take care of already higher rlim_max, rlim_curr
> - Minor tweak in commit text
>
>  tools/power/x86/turbostat/turbostat.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 9a10512e3407..1563a0ae7e4c 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -53,6 +53,8 @@
>  #define        NAME_BYTES 20
>  #define PATH_BYTES 128
>
> +#define MAX_NOFILE 0x8000
> +
>  enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
>  enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUN=
TER_USEC };
>  enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
> @@ -6717,6 +6719,22 @@ void cmdline(int argc, char **argv)
>         }
>  }
>
> +void set_rlimit(void)
> +{
> +       struct rlimit limit;
> +
> +       if (getrlimit(RLIMIT_NOFILE, &limit) < 0)
> +               err(1, "Failed to get rlimit");
> +
> +       if (limit.rlim_max < MAX_NOFILE)
> +               limit.rlim_max =3D MAX_NOFILE;
> +       if (limit.rlim_cur < MAX_NOFILE)
> +               limit.rlim_cur =3D MAX_NOFILE;
> +
> +       if (setrlimit(RLIMIT_NOFILE, &limit) < 0)
> +               err(1, "Failed to set rlimit");
> +}
> +
>  int main(int argc, char **argv)
>  {
>         outf =3D stderr;
> @@ -6729,6 +6747,9 @@ int main(int argc, char **argv)
>
>         probe_sysfs();
>
> +       if (!getuid())
> +               set_rlimit();
> +
>         turbostat_init();
>
>         msr_sum_record();
> --
> 2.34.1
>


--=20
Len Brown, Intel

