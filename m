Return-Path: <linux-pm+bounces-15686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C299F730
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE9E1F2793A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 19:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02F1F80C7;
	Tue, 15 Oct 2024 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px+X0x7c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94B1F80A0;
	Tue, 15 Oct 2024 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020187; cv=none; b=irTEOA6vlqa7B3HTMgUDVI/s4OIBrO+gUiZKk/XP8EaxuJkzC700rT5VD5mS3k/O8sw+kQ3neRP7Mj4j7N0yyyhZfi7deCXlR933IjQ8ZYbBDKsdhdV9FEAiTfXQwxagD21F2gA3lPRyjTRwtIPHEV6Obk9hZ0Fba1Dg+BjMcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020187; c=relaxed/simple;
	bh=AimJ2Bumh9mBtdh9JV2TDD6hXkRt8u1o4jLAIlskq/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZS8upI1qmSTj08rwq0CyJHvuJdkbvnn/+qAtskgjBNyrvyYGRZesCLEBDXnsTQ+QnCOwH8+y+pxys33XXhtkb7Wj8YQScGaQBn8LfaGmUEtq+eeuf18CLn8HhzlUrzswk8wiDQuaL1yLKfhJy8NlfAiwccr5FZ5Xhey7CWn0V+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px+X0x7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5C0C4CEC6;
	Tue, 15 Oct 2024 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729020187;
	bh=AimJ2Bumh9mBtdh9JV2TDD6hXkRt8u1o4jLAIlskq/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Px+X0x7cA0ZcXOWXADTYtS4iYAnNgGr95HUIoISvt0kYbxScjetKMwniCNLn1q7eK
	 8Ck774T1yUJ4vm7fzhUWmJVhXyzzkyCf8tDLQ3jHDok/3SdEohu/fqHTL9MYfBwrfZ
	 CO4MHdGFlppKk1sAK6uCytRZKtUUyY+fzgBlqZfn+kT6WSMavIfPpctSS5Syw0m+Sl
	 LHMVz7pqfNwaYtCRBhspF5OydEdpKo0S6vOEW+Rx84T4kVHE+xcRuV2vyTrxEG1VTP
	 LTuVNwyZNDqqBrFkkAn05mxLtGP+k/vOk2AYg7o7YSVcLdIYpp44CoLEjNZIxPn7Tq
	 gXyH8hbC/I+Dg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-277e6002b7dso1650018fac.1;
        Tue, 15 Oct 2024 12:23:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWllJtkDRQPeDasljhuc/Ocw0MwmgiUyKWADB6pIlfBQRQP2wCTzqIOLVaUKAPrrKRDbOrepHI/Og3j5Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT/V28anfbI4LwwlAK6EFXbhyFbzvYSgJDsxa8VjBIlz1tLGu4
	X/gG/fyoWu8abiNsFqrmb0z87OpQoEUIP00RkiTUcmrvpb+E7wkMxeaz3J6f3LjO32FdvqUnL8c
	JLhCP4xwJTllcw6cjWujliUtD/YU=
X-Google-Smtp-Source: AGHT+IHcihYeTz4OkbONhaZ/U3VFT2bJ1/ifWVPweelyxtgV+GfFBKtl2QtmLjnVXnAuJi/JDnqLn9jOSSn01m2jyTw=
X-Received: by 2002:a05:6870:671a:b0:250:756b:b1ed with SMTP id
 586e51a60fabf-28887348c9amr8582991fac.19.1729020186574; Tue, 15 Oct 2024
 12:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912055956.30108-1-todd.e.brandt@intel.com>
In-Reply-To: <20240912055956.30108-1-todd.e.brandt@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Oct 2024 21:22:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i9F4JUyxAU49=HwZFdv0MZNTeU=F2PdTf-GspCy4OS+w@mail.gmail.com>
Message-ID: <CAJZ5v0i9F4JUyxAU49=HwZFdv0MZNTeU=F2PdTf-GspCy4OS+w@mail.gmail.com>
Subject: Re: [PATCH] pm-graph v5.13
To: Todd Brandt <todd.e.brandt@intel.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net, 
	linux-kernel@vger.kernel.org, todd.e.brandt@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 8:00=E2=80=AFAM Todd Brandt <todd.e.brandt@intel.co=
m> wrote:
>
> - fix link to pm-graph homepage and in comments
> - add usleep_range kprobe to -dev mode
> - add SIGUSR1 and SIGUSR2 to list of captured signals
> - kill -s USR1 causes sleepgraph to print out stack trace
> - kill -s USR2 prints stack trace and exits
> - stack trace is also printed to -result file
> - add legacy support for /sys/kernel/debug/tracing/
> - allow multiple instances of trace funcs in the same phase
> - update javascript to draw device detail for multiple trace func instanc=
es
> - add -debugtiming option to print out timestamps on all outputs
>
> Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> ---
>  tools/power/pm-graph/sleepgraph.8  |  3 ++
>  tools/power/pm-graph/sleepgraph.py | 59 ++++++++++++++++++++++--------
>  2 files changed, 47 insertions(+), 15 deletions(-)
>
> diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sle=
epgraph.8
> index 643271b6fc6f..491ca21dccdb 100644
> --- a/tools/power/pm-graph/sleepgraph.8
> +++ b/tools/power/pm-graph/sleepgraph.8
> @@ -81,6 +81,9 @@ as resume failures.
>  .TP
>  \fB-wifitrace\fR
>  Trace through the wifi reconnect time and include it in the timeline.
> +.TP
> +\fB-debugtiming\fR
> +Add timestamp to each printed output line, accurate to the millisecond.
>
>  .SS "advanced"
>  .TP
> diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sl=
eepgraph.py
> index ef87e63c05c7..918eae58b0b4 100755
> --- a/tools/power/pm-graph/sleepgraph.py
> +++ b/tools/power/pm-graph/sleepgraph.py
> @@ -18,7 +18,7 @@
>  #
>  # Links:
>  #       Home Page
> -#         https://01.org/pm-graph
> +#         https://www.intel.com/content/www/us/en/developer/topic-techno=
logy/open/pm-graph/overview.html
>  #       Source repo
>  #         git@github.com:intel/pm-graph
>  #
> @@ -65,6 +65,7 @@ import gzip
>  from threading import Thread
>  from subprocess import call, Popen, PIPE
>  import base64
> +import traceback
>
>  debugtiming =3D False
>  mystarttime =3D time.time()
> @@ -86,7 +87,7 @@ def ascii(text):
>  #       store system values and test parameters
>  class SystemValues:
>         title =3D 'SleepGraph'
> -       version =3D '5.12'
> +       version =3D '5.13'
>         ansi =3D False
>         rs =3D 0
>         display =3D ''
> @@ -236,7 +237,11 @@ class SystemValues:
>                 'msleep': { 'args_x86_64': {'time':'%di:s32'}, 'ub': 1 },
>                 'schedule_timeout': { 'args_x86_64': {'timeout':'%di:s32'=
}, 'ub': 1 },
>                 'udelay': { 'func':'__const_udelay', 'args_x86_64': {'loo=
ps':'%di:s32'}, 'ub': 1 },
> -               'usleep_range': { 'args_x86_64': {'min':'%di:s32', 'max':=
'%si:s32'}, 'ub': 1 },
> +               'usleep_range': {
> +                       'func':'usleep_range_state',
> +                       'args_x86_64': {'min':'%di:s32', 'max':'%si:s32'}=
,
> +                       'ub': 1
> +               },
>                 'mutex_lock_slowpath': { 'func':'__mutex_lock_slowpath', =
'ub': 1 },
>                 'acpi_os_stall': {'ub': 1},
>                 'rt_mutex_slowlock': {'ub': 1},
> @@ -342,15 +347,21 @@ class SystemValues:
>                 if self.verbose or msg.startswith('WARNING:'):
>                         pprint(msg)
>         def signalHandler(self, signum, frame):
> -               if not self.result:
> -                       return
>                 signame =3D self.signames[signum] if signum in self.signa=
mes else 'UNKNOWN'
> -               msg =3D 'Signal %s caused a tool exit, line %d' % (signam=
e, frame.f_lineno)
> +               if signame in ['SIGUSR1', 'SIGUSR2', 'SIGSEGV']:
> +                       traceback.print_stack()
> +                       stack =3D traceback.format_list(traceback.extract=
_stack())
> +                       self.outputResult({'stack':stack})
> +                       if signame =3D=3D 'SIGUSR1':
> +                               return
> +               msg =3D '%s caused a tool exit, line %d' % (signame, fram=
e.f_lineno)
> +               pprint(msg)
>                 self.outputResult({'error':msg})
> +               os.kill(os.getpid(), signal.SIGKILL)
>                 sys.exit(3)
>         def signalHandlerInit(self):
>                 capture =3D ['BUS', 'SYS', 'XCPU', 'XFSZ', 'PWR', 'HUP', =
'INT', 'QUIT',
> -                       'ILL', 'ABRT', 'FPE', 'SEGV', 'TERM']
> +                       'ILL', 'ABRT', 'FPE', 'SEGV', 'TERM', 'USR1', 'US=
R2']
>                 self.signames =3D dict()
>                 for i in capture:
>                         s =3D 'SIG'+i
> @@ -859,6 +870,11 @@ class SystemValues:
>                 # files needed for any trace data
>                 files =3D ['buffer_size_kb', 'current_tracer', 'trace', '=
trace_clock',
>                                  'trace_marker', 'trace_options', 'tracin=
g_on']
> +               # legacy check for old systems
> +               if not os.path.exists(self.tpath+'trace'):
> +                       self.tpath =3D '/sys/kernel/debug/tracing/'
> +               if not os.path.exists(self.epath):
> +                       self.epath =3D '/sys/kernel/debug/tracing/events/=
power/'
>                 # files needed for callgraph trace data
>                 tp =3D self.tpath
>                 if(self.usecallgraph):
> @@ -911,6 +927,13 @@ class SystemValues:
>                 if num > 0:
>                         n =3D '%d' % num
>                 fp =3D open(self.result, 'a')
> +               if 'stack' in testdata:
> +                       fp.write('Printing stack trace:\n')
> +                       for line in testdata['stack']:
> +                               fp.write(line)
> +                       fp.close()
> +                       self.sudoUserchown(self.result)
> +                       return
>                 if 'error' in testdata:
>                         fp.write('result%s: fail\n' % n)
>                         fp.write('error%s: %s\n' % (n, testdata['error'])=
)
> @@ -1980,7 +2003,7 @@ class Data:
>                 length =3D -1.0
>                 if(start >=3D 0 and end >=3D 0):
>                         length =3D end - start
> -               if pid =3D=3D -2 or name not in sysvals.tracefuncs.keys()=
:
> +               if pid >=3D -2:
>                         i =3D 2
>                         origname =3D name
>                         while(name in list):
> @@ -2753,7 +2776,8 @@ class Timeline:
>         def createHeader(self, sv, stamp):
>                 if(not stamp['time']):
>                         return
> -               self.html +=3D '<div class=3D"version"><a href=3D"https:/=
/01.org/pm-graph">%s v%s</a></div>' \
> +               self.html +=3D '<div class=3D"version"><a href=3D"https:/=
/www.intel.com/content/www/'+\
> +                       'us/en/developer/topic-technology/open/pm-graph/o=
verview.html">%s v%s</a></div>' \
>                         % (sv.title, sv.version)
>                 if sv.logmsg and sv.testlog:
>                         self.html +=3D '<button id=3D"showtest" class=3D"=
logbtn btnfmt">log</button>'
> @@ -5238,12 +5262,16 @@ def addScriptCode(hf, testruns):
>                                 }
>                                 var info =3D dev[i].title.split(" ");
>                                 var pname =3D info[info.length-1];
> -                               pd[pname] =3D parseFloat(info[info.length=
-3].slice(1));
> -                               total[0] +=3D pd[pname];
> +                               var length =3D parseFloat(info[info.lengt=
h-3].slice(1));
> +                               if (pname in pd)
> +                                       pd[pname] +=3D length;
> +                               else
> +                                       pd[pname] =3D length;
> +                               total[0] +=3D length;
>                                 if(pname.indexOf("suspend") >=3D 0)
> -                                       total[tidx] +=3D pd[pname];
> +                                       total[tidx] +=3D length;
>                                 else
> -                                       total[tidx+1] +=3D pd[pname];
> +                                       total[tidx+1] +=3D length;
>                         }
>                 }
>                 var devname =3D deviceTitle(this.title, total, cpu);
> @@ -5262,7 +5290,7 @@ def addScriptCode(hf, testruns):
>                                         phases[i].style.left =3D left+"%"=
;
>                                         phases[i].title =3D phases[i].id+=
" "+pd[phases[i].id]+" ms";
>                                         left +=3D w;
> -                                       var time =3D "<t4 style=3D\"font-=
size:"+fs+"px\">"+pd[phases[i].id]+" ms<br></t4>";
> +                                       var time =3D "<t4 style=3D\"font-=
size:"+fs+"px\">"+pd[phases[i].id].toFixed(3)+" ms<br></t4>";
>                                         var pname =3D "<t3 style=3D\"font=
-size:"+fs2+"px\">"+phases[i].id.replace(new RegExp("_", "g"), " ")+"</t3>"=
;
>                                         phases[i].innerHTML =3D time+pnam=
e;
>                                 } else {
> @@ -6742,6 +6770,7 @@ def printHelp():
>         '   -wifi        If a wifi connection is available, check that it=
 reconnects after resume.\n'\
>         '   -wifitrace   Trace kernel execution through wifi reconnect.\n=
'\
>         '   -netfix      Use netfix to reset the network in the event it =
fails to resume.\n'\
> +       '   -debugtiming Add timestamp to each printed line\n'\
>         '  [testprep]\n'\
>         '   -sync        Sync the filesystems before starting the test\n'=
\
>         '   -rs on/off   Enable/disable runtime suspend for all devices, =
restore all after test\n'\
> @@ -7047,7 +7076,6 @@ if __name__ =3D=3D '__main__':
>                         except:
>                                 doError('No result file supplied', True)
>                         sysvals.result =3D val
> -                       sysvals.signalHandlerInit()
>                 else:
>                         doError('Invalid argument: '+arg, True)
>
> @@ -7057,6 +7085,7 @@ if __name__ =3D=3D '__main__':
>         if(sysvals.usecallgraph and sysvals.useprocmon):
>                 doError('-proc is not compatible with -f')
>
> +       sysvals.signalHandlerInit()
>         if sysvals.usecallgraph and sysvals.cgskip:
>                 sysvals.vprint('Using cgskip file: %s' % sysvals.cgskip)
>                 sysvals.setCallgraphBlacklist(sysvals.cgskip)
> --

Applied as 6.13 material, thanks!

